set block_encryption_mode = 'aes-256-cbc';
select aes_encrypt('ABC','key');

select hex(aes_encrypt('Hola mundo','contraseña')) into @a from dual;
select @a;
select aes_decrypt(unhex(@a),'contraseña') from dual;

-- Con esto si no funciona fuerza a encriptar en 16 bytes, si la cadena supera los 16 bytes lo divide en cadena de 16 bytes.
set @IV=random_bytes(16);
select aes_decrypt(unhex(@a),'contraseña',@IV) from dual;