package icube.common.framework;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;

@EnableWebMvc
@Configuration
public class WebConfig implements WebMvcConfigurer {

	
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/core/**")
                .addResourceLocations("/html/core/")
                .setCacheControl(CacheControl.maxAge(10, TimeUnit.MINUTES));
        
        // 요양등급 테스트 정적리소스
        registry.addResourceHandler("/find/**")
		.addResourceLocations("/test-simulator/static/find/")
		.resourceChain(true)
		.addResolver(new PathResourceResolver() {
			@Override
			protected Resource getResource(String resourcePath, Resource location) throws IOException {
				Resource requestedResource = location.createRelative(resourcePath);
                if (requestedResource.exists() && requestedResource.isReadable()) {
                    return requestedResource;
                } else if (resourcePath.startsWith("step2-1")) {
                    return location.createRelative("/step2-1.html");
                } else if (resourcePath.startsWith("step2-1/behavior")) {
                    return location.createRelative("/step2-1/behavior.html");
                } else if (resourcePath.startsWith("step2-1/cognitive")) {
                    return location.createRelative("/step2-1/cognitive.html");
                } else if (resourcePath.startsWith("step2-1/disease")) {
                    return location.createRelative("/step2-1/disease.html");
                } else if (resourcePath.startsWith("step2-1/finish")) {
                    return location.createRelative("/step2-1/finish.html");
                } else if (resourcePath.startsWith("step2-1/nurse")) {
                    return location.createRelative("/step2-1/nurse.html");
                } else if (resourcePath.startsWith("step2-1/physical")) {
                    return location.createRelative("/step2-1/physical.html");
                } else if (resourcePath.startsWith("step2-1/rehabilitate")) {
                    return location.createRelative("/step2-1/rehabilitate.html");
                } else {
                    throw new FileNotFoundException();
                }
			}
		});
		
		registry.addResourceHandler("/_next/static/**")
		.addResourceLocations("/test-simulator/static/_next/static/");
		
		registry.addResourceHandler("/images/**")
		.addResourceLocations("/test-simulator/static/images/");
		
		registry.addResourceHandler("/imgs/**")
		.addResourceLocations("/test-simulator/static/imgs/");
		
		registry.addResourceHandler("/css/**")
		.addResourceLocations("/test-simulator/static/css/");
		
		registry.addResourceHandler("/manifest.json")
		.addResourceLocations("/test-simulator/static/manifest.json");
    }
	
}
