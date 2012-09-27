## Overview

This application provides a form for creating a Certificate Signing Request. The application will create a public/private keypair, encrypt the private key with a random 16 byte secret key, generate the CSR and try to mail the generated CSR to [&#105;&#110;&#102;&#111;&#64;&#117;&#102;&#112;&#46;&#99;&#111;&#109;](mailto:&#105;&#110;&#102;&#111;&#64;&#117;&#102;&#112;&#46;&#99;&#111;&#109;).

To build this application, assuming you have a working Ruby/RoR environment, do:

    bundle install
    rails s

which installs the required gems and starts a rails server on http://localhost:3000. With a browser, go to [http://localhost:3000/](http://localhost:3000/) and you are presented a form and instructions for how to create the CSR. After entering the required information, the key, keypair and CSR will be written to the tmp directory. An attempt will be made to mail the CSR.

## Certificate Signing Request

In order to connect to the ufpIdentity service client authenticated SSL is required. The examples and libraries take care of most of this for you, however you must have a certificate and private key. It is important you do this, so no one but you has access to the private key. This form will generate a Certificate Signing Request, a private key and a secret key that encrypts the private key. All you need to do is enter in a few fields describing your company.

Make sure to read carefully and enter the values in carefully. If there are errors or inconsistencies we will ask you to redo the certificate signing request. The elements you will need to provide are as follows:

* Country Code

    > This is a two-letter country code. You can find your own country code [here](http://www.iso.org/iso/country_names_and_code_elements).

* State or Province Name

    > This is the state or province name fully spelled out, so California rather than CA or any postal abbreviation.

* Locality

    > This further identifies your location, city or other. Again this is fully spelled out so San Francisco rather than SF or any other abbreviation.

* Company/Organization

    > This is your full company name as its registered. The exact abbreviations are required to match however your company is actually registered.

* Organizational Unit

    > This is to further identify what department of your organization is going to be utilizing the ufpIdentity service. This field is not required, but is useful for organizational purposes.

* Domain Name

    > Put some thought into your domain name as this is how the ufpIdentity service will identify you. You can put anything you like here but typical examples are your actual domain name e.g. example.com which would allow you to use the ufpIdentity service for a host of machines. You can also tie it to specific machine e.g. www.example.com. Any unique identifier will work but if you have questions please dont hesitate to [contact us](mailto:&#105;&#110;&#102;&#111;&#64;&#117;&#102;&#112;&#46;&#99;&#111;&#109;).

* Email

   > This should be a valid email and should allow us to contact someone responsible.

## Using the generated credentials

Upon successful completion of the Certificate Generation process you should have three new files in the tmp directory. The file name prefix is the common name you chose. The three files are the secret key (.key), the public/private key encrypted with the secret key (.key.pem), and the certificate signing request (.csr.pem). Within 24 hours of mailing the certificate signing request to us, you should receive a certificate named with the same common name prefix (.crt.pem). Then you need to configure the public/private key and the secret key to decrypt, the certificate, and the truststore which is provided with most examples.