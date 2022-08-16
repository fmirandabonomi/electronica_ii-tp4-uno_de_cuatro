# Trabajo práctico 4 - Electrónica II 2022 para ingeniería electrónica - Decodificador y codificador one-hot

Debes implementar un decodificador de binario a uno de cuatro y un codificador de uno de cuatro a binario. El código uno de cuatro es un código de cuatro bits donde un bit es uno y el resto es cero, corresponde a la familia de códigos one-hot (uno activo). Este código sirve para seleccionar elementos (el elemento conectado al bit en uno es el seleccionado) y por ello el

Un decodificador uno de cuatro tiene una entrada de dos bits y una salida de cuatro bits. Solo un bit de salida está en uno por vez, el correspondiente a la posición seleccionada por la entrada interpretada como
número binario. Ejemplos:

- Selección "00" -> salida "0001"
- Selección "10" -> salida "0100"

Un codificador uno de 4 a binario tiene una entrada de cuatro bits, una salida de código de dos bits y una salida indicadora de dato válido de un bit. Cuando en la entrada hay un solo uno el código de salida es la posición del uno en código binario. Si todos los bits de entrada son cero o hay más de un uno el dato es inválido.

- Entrada "0000" -> Inválido
- Entrada "0001" -> Válido, código "00"
- Entrada "0100" -> Válido, código "10"
- Entrada "0101" -> Inválido, más de un uno

Para ejecutar las pruebas `mingw32-make run` o `make run` según corresponda.

El práctico está completo si pasa todas las pruebas.