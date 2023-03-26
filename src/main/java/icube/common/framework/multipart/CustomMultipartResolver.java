package icube.common.framework.multipart;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import icube.common.util.StringUtil;
import icube.common.util.XSSUtil;

public class CustomMultipartResolver extends CommonsMultipartResolver {

	private static Logger log = LoggerFactory.getLogger(CustomMultipartResolver.class);
    public CustomMultipartResolver() {
        super();
    }

    /**
     * Constructor for standalone usage. Determines the servlet container's
     * temporary directory via the given ServletContext.
     * @param servletContext the ServletContext to use
     */
	public CustomMultipartResolver(ServletContext servletContext) {
        this();
        setServletContext(servletContext);
    }

    @Override
    protected MultipartParsingResult parseRequest(HttpServletRequest request) throws MultipartException {

		String servletPath = ((HttpServletRequest) request).getServletPath();
		String encoding = determineEncoding(request);

        FileUpload fileUpload = prepareFileUpload(encoding);
        try {
            List<FileItem> fileItems = ((ServletFileUpload) fileUpload).parseRequest(request);
            MultipartParsingResult res=parseFileItems(fileItems, encoding);

			Map<String, String[]> params = res.getMultipartParameters();

			Map<String, String[]> modifiedRes = new HashMap<String, String[]>();

			for (Entry<String, String[]> entry : params.entrySet()) {

                if(entry.getValue().length>0){
                    String val=Arrays.toString(entry.getValue());

                    if(!StringUtil.isEmpty(val)
                    		&& !"/".equals(servletPath)
                    		&& servletPath.indexOf("#{props['Globals.Manager.path']}") == -1				//관리자 제외
                    ){
                    	log.info("################################## In CustomMultipartResolver XSS filter: Yes ");
						String cleanedString = XSSUtil.stripXSS(val);
						String[] valModified = new String[] { cleanedString.substring(1, cleanedString.length() - 1) };
                        modifiedRes.put(entry.getKey(), valModified);
                    }
                    else{
                    	log.info("################################## In CustomMultipartResolver XSS filter: No ");
                        modifiedRes.put(entry.getKey(), entry.getValue());
                    }
                }
                else{
                	log.info("################################## In CustomMultipartResolver XSS filter: No ");
                    modifiedRes.put(entry.getKey(), entry.getValue());
                }
            }

			MultipartParsingResult modifiedResp = new MultipartParsingResult(res.getMultipartFiles(), modifiedRes, res.getMultipartParameterContentTypes());
            return modifiedResp;
        }
		catch (FileUploadBase.SizeLimitExceededException ex) {
			throw new MaxUploadSizeExceededException(fileUpload.getSizeMax(), ex);
        }
        catch (FileUploadException ex) {
            throw new MultipartException("Could not parse multipart servlet request", ex);
        }
    }

}
