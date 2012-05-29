# -*- coding: utf-8 -*-
# =スマートフォンの親クラス

module Jpmobile::Mobile
  class SmartPhone < AbstractMobile
    # 無効化
    def valid_ip?
      false
    end

    # cookie は有効と見なす
    def supports_cookie?
      true
    end

    # smartphone なので true
    def smart_phone?
      true
    end

#     # Jpmobile::Rack::Filter は適用しない
#     def apply_filter?
#       false
#     end

#     # Jpmobile::Rack::ParamsFilter は適用しない
#     def apply_params_filter?
#       false
#     end

# 以下、モバゲー仕様に合わせてスマホは全てSoftbankのUnicodeに変換する
    # Jpmobile::Rack::Filter を適用する
    def apply_filter?
      true
    end

    # Jpmobile::Rack::ParamsFilter を適用する
    def apply_params_filter?
      true
    end

    # 文字コード変換
    def to_internal(str)
      # 絵文字を数値参照に変換
      str = Jpmobile::Emoticon.external_to_unicodecr_softbank(Jpmobile::Util.utf8(str))
      # 数値参照を UTF-8 に変換
      Jpmobile::Emoticon.unicodecr_to_utf8(str)
    end
    def to_external(str, content_type, charset)
      # UTF-8を数値参照に
      str = Jpmobile::Emoticon.utf8_to_unicodecr(str)
      # 数値参照を絵文字コードに変換
      str = Jpmobile::Emoticon.unicodecr_to_external(str, Jpmobile::Emoticon::CONVERSION_TABLE_TO_SOFTBANK, false)

      [str, charset]
    end
  end
end
