/*
 * nrf24.c
 *
 *  Created on: 16/01/2021
 *      Author: Harry Dobbs
 */
#include "main.h"
#include "nrf24.h"


void NRF24_Init(void)
{
	//Power down
	NRF24_write_register(NRF_CONFIG,POWER_DOWN,POWER_MASK);
	HAL_Delay(10);

	//Small power usage
	NRF24_write_register(NRF_SETUP ,RF_PWR_18db,RF_PWR_MASK);

	//lower DR speed
	NRF24_write_register(NRF_SETUP ,RF_DR_LOW,RF_DR_MASK);

	NRF24_write_register(NRF_SETUP_RETR,ARD_750us,ARD_MASK);

	// Enable Dynamic Payload : Reg Feature bit EN_DPL
	NRF24_write_register(NRF_FEATURE ,EN_DPL,EN_DPL_MASK);
	NRF24_write_register(NRF_DYNPD ,EN_DPL_P0,EN_DPL_P0_MASK);
}


void NRF24_TX_Init(void)
{
	NRF24_write_register(STATUS1 ,RX_DR_SET,RX_DR_MASK);
	NRF24_write_register(STATUS1 ,TX_DS_SET,TX_DS_MSAK);
	NRF24_write_register(STATUS1 ,MAX_RT_SET,MAX_RT_MASK);
	NRF24_CMD(FLUSH_RX);
	NRF24_CMD(FLUSH_TX);
	NRF24_write_register(STATUS1,PRIM_TX,PRIM_RX_MASK);
	NRF24_write_register(STATUS1 ,POWER_UP,POWER_MASK);
	HAL_Delay(10);
	nRF24_CE_H();

}

void NRF24_RX_Init(void)
{

	NRF24_write_register(NRF_STATUS ,RX_DR_SET,RX_DR_MASK);
	NRF24_write_register(NRF_STATUS ,TX_DS_SET,TX_DS_MSAK);
	NRF24_write_register(NRF_STATUS ,MAX_RT_SET,MAX_RT_MASK);
	NRF24_CMD(FLUSH_RX);
	NRF24_CMD(FLUSH_TX);
	NRF24_write_register(NRF_CONFIG,PRIM_RX,PRIM_RX_MASK);
	NRF24_write_register(NRF_CONFIG ,POWER_UP,POWER_MASK);
	HAL_Delay(10);
	nRF24_CE_H();
}



uint8_t NRF24_read_register(uint8_t reg)
{

	uint8_t spi_rx;
	nRF24_CSN_L();
	HAL_SPI_Transmit(&hspi3,(uint8_t *) (R_REGISTER | ( REGISTER_MASK & reg )), 1, 100);
	HAL_SPI_Receive(&hspi3, &spi_rx, 1, 100);
	nRF24_CSN_H();
	return spi_rx;
}


uint8_t NRF24_write_register(uint8_t reg_add, uint8_t new_value, uint8_t mask)
{
	uint8_t reg_value, new_reg_value, cmd;

	cmd = (W_REGISTER | reg_add);
	reg_value = NRF24_read_register(reg_add);
	new_reg_value = (reg_value & mask) | new_value;

	nRF24_CSN_L();
	HAL_SPI_Transmit(&hspi3,&cmd,1, 100);
	HAL_SPI_Transmit(&hspi3,&new_reg_value,1, 100);
	nRF24_CSN_H();

	reg_value = NRF24_read_register(reg_add);
	if(reg_value == new_reg_value)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}


void NRF24_CMD(uint8_t cmd)
{
	nRF24_CSN_L();
	HAL_SPI_Transmit(&hspi3,&cmd,1, 100);
	nRF24_CSN_H();
}


// nrf_rf_tx(payload)

void NRF24_RF_TX(uint8_t payload[])
{
	int i = 0;
	if(NRF24_read_register(NRF_CONFIG) & 1)
	{
		NRF24_TX_Init();
	}
	nRF24_CSN_L();

	uint8_t cmd = W_TX_PAYLOAD;

	HAL_SPI_Transmit(&hspi3,&cmd,1, 100);

	while(payload[i])
	{
		HAL_SPI_Transmit(&hspi3,&payload[i],1, 100);
		i++;
	}
	nRF24_CSN_H();

}


// nrf_rf_rx(payload)
void NRF24_RF_RX(uint8_t payload[])
{
	uint8_t payload_w = 0;
	int i;

	uint8_t cmd = R_RX_PL_WID;


	HAL_SPI_Transmit(&hspi3,&cmd,1, 100);

	HAL_SPI_Receive(&hspi3,&payload_w,1, 100);


	nRF24_CSN_L();

	cmd = R_RX_PAYLOAD;
	HAL_SPI_Transmit(&hspi3,&cmd,1, 100);

	for(i=0;i<payload_w;i++)
	{
		HAL_SPI_Transmit(&hspi3,&cmd,1, 100);
		HAL_SPI_Receive(&hspi3,&payload[i],1, 100);
	}
	nRF24_CSN_H();
	NRF24_write_register(NRF_STATUS ,RX_DR_SET,RX_DR_MASK);
	NRF24_CMD(FLUSH_RX);
}


