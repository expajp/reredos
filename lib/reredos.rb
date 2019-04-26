require "reredos/version"

module Reredos
  class Error < StandardError; end
  EMAIL_MAX_LENGTH        = 256 # メールアドレスの最大長
  DOMAIN_MAX_LENGTH       = 255 # ドメインの最大長
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
      return false if str[-1] == '-' # 末尾は-でない

      labels = str.split('.')
      return false if labels.map(&:length).any?{ |_| _ > DOMAIN_LABEL_MAX_LENGTH }
      return false unless labels.map{ |_| /\A[0-9a-zA-Z\-]+\z/ === _ }.all? # ラベルに含まれる文字が1文字以上の英数字orハイフン

      true
    end

    def valid_username?(str)
      return false if str.length > USERNAME_MAX_LENGTH
      /\A[0-9a-zA-Z\.\+\-\_]+\z/ === str # 既定の文字のみで構成されている
    end
  end
end
