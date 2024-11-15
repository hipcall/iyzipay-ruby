module Iyzipay
  module Model
    class PaymentPostAuth < IyzipayResource

      def create(request = {}, options)
        pki_string = to_pki_string(request)
        request_path = "/payment/iyzipos/postauth"
        HttpClient.post("#{options.base_url}#{request_path}", get_http_header(request_path, request.to_json, options), request.to_json)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super).
            append(:paymentId, request[:paymentId]).
            append(:ip, request[:ip]).
            append_price(:paidPrice, request[:paidPrice]).
            append(:currency, request[:currency]).
            get_request_string
      end
    end
  end
end