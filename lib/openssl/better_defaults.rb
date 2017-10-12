require 'openssl/better_defaults/version'
require 'openssl'

# = Changes made by openssl/better_defaults
#
# == Miscellaneous resources
#
# 1. https://www.ruby-lang.org/en/news/2014/10/27/changing-default-settings-of-ext-openssl
# 2. https://en.wikipedia.org/wiki/Transport_Layer_Security
# 3. https://wiki.mozilla.org/Security/Server_Side_TLS
# 4. https://ssllabs.com
# 5. https://ssllabs.com/downloads/SSL_TLS_Deployment_Best_Practices.pdf
#
# == Rationale for disabling features
#
#    Reason          | Disabled features               | Notes
#    ==============================================================================
#                    | SSL 2.0                         | https://tools.ietf.org/html/rfc6176
#    BEST, LUCKY13   | SSL 3.0 Ciphers using CBC mode  |
#    POODLE          | SSL 3.0                         |
#    RC4 weaknesses  | All RC4-based ciphers           |
#    CRIME           | TLS Compression                 | http://arstechnica.com/security/2012/09/crime-hijacks-https-sessions/
#
# === Note on CRIME/BREACH
#
# Disabling TLS compression avoids CRIME at the TLS level. However, both CRIME
# and BREACH can be used against HTTP compression­-- which is entirely out
# of the scope of this library.
#
# See also, http://en.wikipedia.org/wiki/CRIME
#
# === Note on SSL/TLS versions
#
# Instead of being able to specify a minimum SSL version, OpenSSL only lets you
# either enable an individual version, or enable everything.
#
# Individual options for disabling SSL 2.0 and SSL 3.0 are also available.
#
# Thus, to enable TLS 1.0+ only, you have to:
#
# 1. Enable SSL 2.0+ (set ssl_version to "SSLv23"), then
# 2. disable SSL 2.0 (OP_NO_SSLv2) and SSL 3.0 (OP_NO_SSLv2).

module OpenSSL
  module SSL
    class SSLContext
      remove_const(:DEFAULT_PARAMS)

      DEFAULT_PARAMS = {
        # Enable SSL 2.0+ and TLS 1.0+. SSL 2.0 and SSL 3.0 are disabled later on.
        # See the above NOTE on SSL versions.
        :ssl_version => "SSLv23",

        # Verify the server's certificate against the certificate authority's
        # certificate.
        :verify_mode => OpenSSL::SSL::VERIFY_PEER,

        # TODO: Review cipher list.
        :ciphers => %w{
          ECDHE-ECDSA-AES128-GCM-SHA256
          ECDHE-RSA-AES128-GCM-SHA256
          ECDHE-ECDSA-AES256-GCM-SHA384
          ECDHE-RSA-AES256-GCM-SHA384
          DHE-RSA-AES128-GCM-SHA256
          DHE-DSS-AES128-GCM-SHA256
          DHE-RSA-AES256-GCM-SHA384
          DHE-DSS-AES256-GCM-SHA384
          ECDHE-ECDSA-AES128-SHA256
          ECDHE-RSA-AES128-SHA256
          ECDHE-ECDSA-AES128-SHA
          ECDHE-RSA-AES128-SHA
          ECDHE-ECDSA-AES256-SHA384
          ECDHE-RSA-AES256-SHA384
          ECDHE-ECDSA-AES256-SHA
          ECDHE-RSA-AES256-SHA

          DHE-RSA-AES128-SHA256
          DHE-RSA-AES256-SHA256
          DHE-RSA-AES128-SHA
          DHE-RSA-AES256-SHA
          DHE-DSS-AES128-SHA256
          DHE-DSS-AES256-SHA256
          DHE-DSS-AES128-SHA
          DHE-DSS-AES256-SHA
          AES128-GCM-SHA256
          AES256-GCM-SHA384
          AES128-SHA256
          AES256-SHA256
          AES128-SHA
          AES256-SHA


          !aNULL
          !eNULL
          !EXPORT
          !DES
          !RC4
          !MD5
          !PSK
          !aECDH
          !EDH-DSS-DES-CBC3-SHA
          !EDH-RSA-DES-CBC3-SHA
          !KRB5-DES-CBC3-SHA

        }.join(":"),
        :options => -> {
          # Start with ALL OF THE OPTIONS EVER ENABLED.
          opts = OpenSSL::SSL::OP_ALL

          # TODO: Determine the ACTUAL PURPOSE of this line.
          # (Was copy/pasted from the undocumented ruby-lang.org version.)
          opts &= ~OpenSSL::SSL::OP_DONT_INSERT_EMPTY_FRAGMENTS if defined?(OpenSSL::SSL::OP_DONT_INSERT_EMPTY_FRAGMENTS)

          # Disable compression, to avoid CRIME exploit.
          opts |= OpenSSL::SSL::OP_NO_COMPRESSION if defined?(OpenSSL::SSL::OP_NO_COMPRESSION)

          # Disable SSL 2.0 and 3.0 here because they conflate versions and options.
          # Seriously. This should not be specified in the options.
          # No. Go home, OpenSSL API, you're drunk.
          #
          # SSL 2.0 is disabled as recommended by RFC 6176 (see table at top of file).
          # SSL 3.0 is disabled due to the POODLE vulnerability.
          opts |= OpenSSL::SSL::OP_NO_SSLv2 if defined?(OpenSSL::SSL::OP_NO_SSLv2)
          opts |= OpenSSL::SSL::OP_NO_SSLv3 if defined?(OpenSSL::SSL::OP_NO_SSLv3)

          opts
        }.call
      }
    end
  end
end

