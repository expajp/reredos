require "reredos/version"

module Reredos
  class Error < StandardError; end
  EMAIL_MAX_LENGTH        = 254 # メールアドレスの最大長
  DOMAIN_MAX_LENGTH       = 253 # ドメインの最大長
  DOMAIN_LABEL_MAX_LENGTH = 63  # ドメインラベルの最大長
  USERNAME_MAX_LENGTH     = 64  # ユーザネームの最大長

  class << self
    def valid_email?(str)
      return false if str.length > EMAIL_MAX_LENGTH
      return false if str.count('@') != 1 # @は一度だけ

      username, domain = str.split('@')
      valid_username?(username) && valid_domain?(domain)
    end

    private

    def valid_domain?(str)
      return false if str.length > DOMAIN_MAX_LENGTH
      return false unless str.split('.', -1).all? { |l| valid_label?(l) }

      true
    end

    def valid_username?(str)
      return false if str.length > USERNAME_MAX_LENGTH
      return false if str.split('.', -1).any?(&:empty?)
      /\A[0-9a-zA-Z\.\+\-\_]+\z/ === str # 既定の文字のみで構成されている
    end

    # ラベルはアルファベットで始まり、アルファベットか数字かハイフンが続き、アルファベットか数字で終わる
    def valid_label?(str)
      return false if str.empty?
      return false if str.length > DOMAIN_LABEL_MAX_LENGTH
      return false unless letter?(str[0])
      return false unless alphanumeric?(str[-1])
      return true if str[1...-1].empty?

      str[1...-1].chars.all? { |c| hyphen_or_alphanumeric?(c) }
    end

    def letter?(char)
      ('a'..'z').include?(char) || ('A'..'Z').include?(char)
    end

    def digit?(char)
      ('0'..'9').include?(char)
    end

    def alphanumeric?(char)
      letter?(char) || digit?(char)
    end

    def hyphen_or_alphanumeric?(char)
      char == '-' || alphanumeric?(char)
    end
  end
end
