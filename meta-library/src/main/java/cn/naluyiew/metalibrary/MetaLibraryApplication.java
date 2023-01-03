package cn.naluyiew.metalibrary;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@EnableCaching
@SpringBootApplication
public class MetaLibraryApplication {
    public static void main(String[] args) {
        SpringApplication.run(MetaLibraryApplication.class, args);
    }
}