{...}:
{
  security.pki.certificates = [
    (builtins.readFile ../../home-ca/home-ca.crt)
  ];
}