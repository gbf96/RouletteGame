import isel.leic.UsbPort

object HAL {
    private var usbPort: Int = 0b00000000

    //Inicia o objeto
    fun init(){
        UsbPort.write(usbPort)
    }

    // Retorna ’true’ se o bit definido pela mask esta com o valor logico ’1’ no UsbPort
    fun isBit(mask: Int): Boolean {
        return (UsbPort.read() and mask) != 0
    }

    // Retorna os valores dos bits representados por mask presentes no UsbPort
    fun readBits(mask: Int): Int {
        return UsbPort.read() and mask
    }

    // Escreve nos bits representados por mask os valores dos bits correspondentes em value
    fun writeBits(mask: Int, value: Int) {
        usbPort = usbPort and mask.inv()
        usbPort = usbPort or (mask and value)
        UsbPort.write(usbPort)
    }

    // Coloca os bits representados por mask no valor lógico ’1’
    fun setBits(mask: Int) {
        usbPort = usbPort or mask
        UsbPort.write(usbPort)
    }

    // Coloca os bits representados por mask no valor lógico ’0’
    fun clrBits(mask: Int) {
        usbPort = usbPort and mask.inv()
        UsbPort.write(usbPort)
    }

}


