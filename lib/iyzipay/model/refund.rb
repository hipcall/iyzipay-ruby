module Iyzipay
  module Model
    class Refund < IyzipayResource

      def create(request = {}, options)
        pki_string = to_pki_string(request)
        request_path = "/payment/iyzipos/refund"
        HttpClient.post("#{options.base_url}#{request_path}", get_http_header(request_path, request.to_json, options), request.to_json)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super).
            append(:paymentTransactionId, request[:paymentTransactionId]).
            append_price(:price, request[:price]).
            append(:ip, request[:ip]).
            append(:currency, request[:currency]).
            append(:reason, request[:reason]).
            append(:description, request[:description]).
            get_request_string
      end
    end
  end
end