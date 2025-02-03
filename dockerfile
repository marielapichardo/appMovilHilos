# 1. Imagen base de Rust
FROM rust:1.72 AS builder

# 2. Crear un directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# 3. Copiar el archivo Cargo.toml y Cargo.lock al contenedor
COPY Cargo.toml Cargo.lock ./

# 4. Descargar las dependencias
RUN cargo fetch

# 5. Copiar el código fuente al contenedor
COPY . .

# 6. Compilar el proyecto en modo release
RUN cargo build --release

# 7. Crear una imagen más ligera para ejecutar la aplicación
FROM debian:buster-slim

# 8. Copiar el binario compilado desde el paso anterior
COPY --from=builder /usr/src/app/target/release/ApiParalela /usr/local/bin/ApiParalela

# 9. Especificar el puerto que usa el backend
EXPOSE 8080

# 10. Comando para ejecutar la aplicación
CMD ["ApiParalela"]