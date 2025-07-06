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
```
