$(document).on('ready', function() {
  $('#checkout_payment').on('click', function() {
    orderId = $(this).data('order-id');
    $.get('/orders/'+ orderId + '/checkout_payment', function(data) {
      const options = {
        "key": data.key_id,
        "amount": data.amount,
        "currency": data.currency,
        "name": data.name,
        "description": data.description,
        "image": "https://example.com/your_logo",
        "order_id": data.order_id,
        "handler": function (response){
          $.get({
            url: '/orders/' + orderId + '/capture_payment',
            data: {
              payment_id: response.razorpay_payment_id,
              order_id: response.razorpay_order_id,
              signature: response.razorpay_signature
            }
          });
        }
      }
      var rzp1 = new Razorpay(options);
      rzp1.open();
      rzp1.on('payment.failed', function (response){
        alert('An error occurred, Could not complete the payment, Error Code: ' + response.error.code);
      });
    });
  });
});