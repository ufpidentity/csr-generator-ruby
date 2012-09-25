require 'openssl'
require 'mail'

class GeneratorController < ApplicationController
  def index
  end

  def csr
    csrParams = params['csr']
    @commonName = csrParams['CN']
    # parse out the DN
    dn = OpenSSL::X509::Name.new
    csrParams.each{|k, v| dn.add_entry(k, v)}
    
    # create a new key
    key = OpenSSL::PKey::RSA.new 2048
    
    # save off the key encrypted with a secret key
    cipher = OpenSSL::Cipher::Cipher.new 'AES-128-CBC'
    secret_key = OpenSSL::Random.random_bytes(16)

    open "tmp/#{@commonName}.key.pem", 'w', 0400 do |io|
      io.write key.export(cipher, secret_key)
    end

    # save off the encrypted key
    open "tmp/#{@commonName}.key", 'w', 0400 do |io|
      io.write secret_key
    end
    
    # generate a request
    csr = OpenSSL::X509::Request.new
    csr.version = 0
    csr.subject = dn
    csr.public_key = key.public_key
    csr.sign key, OpenSSL::Digest::SHA1.new

    # save off the csr
    open "tmp/#{@commonName}.csr.pem", 'w', 0400 do |io|
      io.write csr.to_pem
    end

    @renderText = 'Success.'
    begin
      # try and mail the csr
      Mail.deliver do
        from    csrParams['emailAddress']
        to      'info@ufp.com'
        subject 'Certificate Signing Request'
        body    csr.to_pem
      end
    rescue
      @renderText += " Please <a href=\"mailto:&#105;&#110;&#102;&#111;&#64;&#117;&#102;&#112;&#46;&#99;&#111;&#109;\">email</a> newly generated #{@commonName}.csr.pem"
    end

    render :action => "success"
  end
end
