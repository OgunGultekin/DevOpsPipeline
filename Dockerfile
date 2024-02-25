# Uygulama için JDK gerekli
FROM amazoncorretto:17

# Bizim bu projemizdeki JAR dosyamızın, Docker içinde çalışacağı konumu
ARG JAR_FILE=build/libs/*.jar

# JAR dosyasını root klasörüne bu isimle kopyala
COPY ${JAR_FILE} application.jar

# Linux ortamını güncelle
CMD apt-get update-y

# projenin calisacaği iç port
EXPOSE 7777

# Uygulamamızın çalışmasını sağlıyoruz.
ENTRYPOINT ["java",  "-jar", "/application.jar"]