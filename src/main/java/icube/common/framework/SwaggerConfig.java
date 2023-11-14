package icube.common.framework;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.Parameter;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
@EnableWebMvc
@Profile(value = {"local", "test"})
public class SwaggerConfig implements WebMvcConfigurer {
	
	@Bean
	public Docket api() {
		//전역 인증 header 파라미터 만들기
		List<Parameter> global = new ArrayList<>();
		global.add(new ParameterBuilder().name("eroumAPI_Key")
			.description("Access Token")
			.parameterType("header")
			.required(false)
			.modelRef(new ModelRef("string"))
			.build());
		
		return new Docket(DocumentationType.SWAGGER_2)
				.apiInfo(apiInfo())
				.globalOperationParameters(global)
				.select()
				.apis(RequestHandlerSelectors.basePackage("icube.members.bplc"))
				.paths(PathSelectors.ant("/api/members/**"))
				.build();
	}
	
	private ApiInfo apiInfo() {
		return new ApiInfoBuilder()
				.title("이로움온 연동API 문서")
				.description("이로움케어 등에서 호출하는 API 문서 명세")
				.version("v1.0")
				.contact(new Contact("name", "url", "e-mail"))
				.build();
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
	  registry.addResourceHandler("swagger-ui.html")
            .addResourceLocations("classpath:/META-INF/resources/");

	  registry.addResourceHandler("/webjars/**")
            .addResourceLocations("classpath:/META-INF/resources/webjars/");
	}
}
