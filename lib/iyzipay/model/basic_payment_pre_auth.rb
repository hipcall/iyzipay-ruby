module Iyzipay
  module Model
    class BasicPaymentPreAuth < IyzipayResource

      def create(request = {}, options)
        pki_string = to_pki_string(request)
        request_path = "/payment/iyziconnect/preauth"
        HttpClient.post("#{options.base_url}#{request_path}", get_http_header(request_path, request.to_json, options), request.to_json)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super).
            append_price(:price, request[:price]).
            append_price(:paidPrice, request[:paidPrice]).
            append(:installment, request[:installment]).
            append(:buyerEmail, request[:buyerEmail]).
            append(:buyerId, request[:buyerId]).
            append(:buyerIp, request[:buyerIp]).
            append(:posOrderId, request[:posOrderId]).
            append(:paymentCard, PaymentCard.to_pki_string(request[:paymentCard])).
            append(:currency, request[:currency]).
            append(:connectorName, request[:connectorName]).
            append(:callbackUrl, request[:callbackUrl]).
            get_request_string
      end
    end
  end
end