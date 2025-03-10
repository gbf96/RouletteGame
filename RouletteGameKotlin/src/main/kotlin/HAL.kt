import isel.leic.UsbPort

object HAL {
    private var usbPort: Int = 0b00000000

    //Inicia o objeto
    fun init(){
        usbPort = UsbPort.read()
    }

    // Retorna ’true’ se o bit definido pela mask esta com o valor logico ’1’ no UsbPort
    fun isBit(mask: Int): Boolean {
        return (usbPort and mask) != 0
    }

    // Retorna os valores dos bits representados por mask presentes no UsbPort
    fun readBits(mask: Int): Int {
        return usbPort and mask
    }

    // Escreve nos bits representados por mask os valores dos bits correspondentes em value
    fun writeBits(mask: Int, value: Int) {
        usbPort = usbPort and (mask.inv())
        usbPort = usbPort or (mask and value)
        UsbPort.write(usbPort)
    }

    // Coloca os bits representados por mask no valor lógico ’1’
    fun setBits(mask: Int) {
        usbPort = usbPort or mask
    }

    // Coloca os bits representados por mask no valor lógico ’0’
    fun clrBits(mask: Int) {
        usbPort = usbPort and mask.inv()
    }

}


