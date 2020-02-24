<h1 class="headline form-background">Payment</h1>
<section class="center form-background fullheight">
    <div class="form-wrap">
        <div class="account-form">
            <? if($paymentMethod == "paypal") : ?>
                <img src="assets/images/checkout/PayPalLogo.png" alt="PayPal Logo" class="payPalLogo">
                <div class="price">
                    Total: <?=$_SESSION['priceTotal']?>&euro;
                </div>
            <? endif;?>
            <form method="POST" action="?c=account&a=checkout">
                <button type="submit" name="paidSubmit">Pay Now</button>
            </form>
            <a href="?c=account&a=shoppingcart"><button>Cancel</button></a>
        </div>
        <br>
    </div>
</section>
