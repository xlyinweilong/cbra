
package cn.yoopay.support.exception;

public class DiscountToPriceErrorException extends Exception {

    /**
     * Creates a new instance of <code>AlreadyPaidException</code> without detail message.
     */
    public DiscountToPriceErrorException() {
    }

    /**
     * Constructs an instance of <code>AlreadyPaidException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public DiscountToPriceErrorException(String msg) {
        super(msg);
    }
}
