module Iyzipay
  module Model
    class CrossBookingFromSubMerchant < IyzipayResource

      def create(request = {}, options)
        pki_string = to_pki_string(request)
        request_path = "/crossbooking/receive"
        HttpClient.post("#{options.base_url}#{request_path}", get_http_header(request_path, request.to_json, options), request.to_json)
      end

      def to_pki_string(request)
        PkiBuilder.new.append_super(super).
            append(:subMerchantKey, request[:subMerchantKey]).
            append_price(:price, request[:price]).
            append(:reason, request[:reason]).
            append(:currency, request[:currency]).
            get_request_string
      end
    end
  end
end