# Examen Final Modulo 3

## Creación de un Exchange Descentralizado Simple con Pools de Liquidez

# 🛠️ Instrucciones para Desplegar y Probar SimpleDEX en Remix

## ✅ Prerrequisitos

- Tener una wallet conectada a la red **Scroll Sepolia**.
- Tener saldo en ETH para pagar gas en Scroll Sepolia.
- Acceder a [Remix IDE](https://remix.ethereum.org/).

---

## 🚀 Despliegue en Remix

### 1. Desplegar TokenA

- Abre `TokenA.sol` en Remix.
- Selecciona el compilador de Solidity versión 0.8.x.
- Compila el contrato.
- Ve a la pestaña **Deploy & Run Transactions**.
- Selecciona `Injected Provider - MetaMask`.
- Ingresa el **supply total**, por ejemplo:  
  `1000000000000000000000000` (equivale a 1 millón de tokens con 18 decimales).
- Haz clic en **Deploy**.
- Guarda la dirección del contrato desplegado.

### 2. Desplegar TokenB

- Repite el proceso anterior con `TokenB.sol`.
- Usa el mismo supply inicial.
- Haz clic en **Deploy**.
- Guarda la dirección del contrato desplegado.

### 3. Desplegar SimpleDEX

- Abre `SimpleDEX.sol` en Remix.
- Compila el contrato.
- En la pestaña **Deploy & Run Transactions**, en los parámetros de despliegue ingresa:
  - La dirección de `TokenA`.
  - La dirección de `TokenB`.
- Haz clic en **Deploy**.
- Guarda la dirección del contrato SimpleDEX.

---

## 🛠️ Interacción con el Contrato

### 1. Aprobar el Gasto de Tokens

Selecciona los contratos `TokenA` y `TokenB` en Remix (ya desplegados).

En `approve`, coloca:

- Spender: Dirección del contrato SimpleDEX.
- Amount: La cantidad de tokens que quieres autorizar, por ejemplo: `10000000000000000000` (10 tokens).

Ejecuta `approve` para **ambos tokens**.

### 2. Añadir Liquidez

En SimpleDEX, ejecuta:

```solidity
addLiquidity(amountA, amountB)
swapAforA(amountA, amountB)
swapBforA(amountA, amountB)
reserveA()
reserveB()
```

#Referencias de contratos desplegados

##TokenA
```
status	0x1 Transaction mined and execution succeed
transaction hash	0x163da6dc873bfa59c8f5295e8d02e6556f0ab8791fb5f7cce94e546153cb40f1
block hash	0xdeec340b195f1e1ce4e523c8e91b0d25735d171780b39152418e23ec5bc252e4
block number	8700027
contract address	0xdbbcacbca1a41fd047660dd4de9751d4935b9066
from	0x6d4cCC767B7aa45c5cd0ebBBff1f2c3e632dB03a
to	TokenA.(constructor)
gas	819695 gas
transaction cost	812083 gas 
input	0x608...00000
decoded input	{
	"uint256 total": "1000000000000000000000000"
}
decoded output	 - 
logs	[]
raw logs	[]
```

##TokenB
```
status	0x1 Transaction mined and execution succeed
transaction hash	0xa430511803d1aa2d77a6715ecdb3af7fb9c091e611d3637d318179001b3d0b99
block hash	0x11c14332f550d70cf3dac6392b6f34f659418e82f0a490bd32230d4cfba85f30
block number	8700037
contract address	0x640554e72d1df308170cb4b221c972076f409a18
from	0x6d4cCC767B7aa45c5cd0ebBBff1f2c3e632dB03a
to	TokenB.(constructor)
gas	819695 gas
transaction cost	812083 gas 
input	0x608...00000
decoded input	{
	"uint256 total": "1000000000000000000000000"
}
decoded output	 - 
logs	[]
raw logs	[]
```

##SimpleDEX

```
status	0x1 Transaction mined and execution succeed
transaction hash	0x86cfc51d3d7318000ec276a961956b33f08efdc949f28ee71c5383b62e44c738
block hash	0x642f802531fca34d4fb8668ea3ddd67a7bf05650d9a3f108eab128ad254ad2e7
block number	8701329
contract address	0x37cffb2310876d96d34d396cf7cf0501f911f3c2
from	0x6d4cCC767B7aa45c5cd0ebBBff1f2c3e632dB03a
to	SimpleDEX.(constructor)
gas	1373789 gas
transaction cost	1361814 gas 
input	0x608...09a18
decoded input	{
	"address _tokenA": "0xdBBCAcBcA1A41FD047660Dd4De9751d4935b9066",
	"address _tokenB": "0x640554e72d1dF308170CB4B221c972076F409A18"
}
decoded output	 - 
logs	[]
raw logs	[]
```
