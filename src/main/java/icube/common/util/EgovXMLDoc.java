package icube.common.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.Text;

public class EgovXMLDoc {

	// 파일구분자
	static final char FILE_SEPARATOR = File.separatorChar;

	// 최대 문자길이
	static final int MAX_STR_LEN = 1024;

	// Log
	//protected static final Log log = LogFactory.getLog(EgovXMLDoc.class);

	/**
	 * XML 파일을 파싱하여 데이터를 조작할 수 있는 Document 객체를 반환
	 * @param String xmlFilePath XML파일
	 * @return Document document 문서객체
	 * @exception Exception
	*/
	public static Document getXMLDocument(String xmlFilePath) throws Exception {

		Document xmlDoc = null;

		String file = xmlFilePath.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(file);

		xmlDoc = getXMLDocument(srcFile);

		return xmlDoc;
	}

	/**
	 * XML 파일을 파싱하여 데이터를 조작할 수 있는 Document 객체를 반환
	 * @param File file XML파일
	 * @return Document document 문서객체
	 * @exception Exception
	*/
	public static Document getXMLDocument(File file) throws Exception {
		Document xmlDoc = null;

		FileInputStream fis = null;
		try {
			if (file.exists() && file.isFile() && file.canRead()) {

				fis = new FileInputStream(file);
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = null;
				factory.setValidating(true);
				factory.setIgnoringElementContentWhitespace(true);
				builder = factory.newDocumentBuilder();
				xmlDoc = builder.parse(fis);
			}
		} finally {
			if(fis!=null) {
				fis.close();
			}
		}

		return xmlDoc;
	}

	/**
	 * Document의 최상의 Element로 이동
	 * @param Document document XML데이터
	 * @return Element root 루트
	 * @exception Exception
	*/
	public static Element getRootElement(Document document) throws Exception {

		Element root = document.getDocumentElement();
		return root;
	}

	/**
	 * 하위에 새로운 Elemenet를 생성
	 * @param Document document XML데이터
	 * @prarm Element rt 추가될위치
	 * @param id 생성될 Element의 ID
	 * @return Element element 추가된 Element
	 * @exception Exception
	*/
	public static Element insertElement(Document document, Element rt, String id) throws Exception {

		Element child = null;
		Element root = null;

		if (rt == null) {
			root = getRootElement(document);
		} else {
			root = rt;
		}
		child = document.createElement(id);
		root.appendChild(child);

		return child;
	}

	/**
	 * 하위에 문자열을 가지는 새로운 Elemenet를 생성
	 * @param Document document XML데이터
	 * @prarm Element rt 추가 위치
	 * @param id 생성될 Element의 ID
	 * @param text Element 하위에 들어갈 문자열
	 * @return Element element 추가된 Element
	 * @exception Exception
	*/
	public static Element insertElement(Document document, Element rt, String id, String text) throws Exception {

		Element echild = null;
		Text tchild = null;
		Element root = null;

		if (rt == null) {
			root = getRootElement(document);
		} else {
			root = rt;
		}
		echild = document.createElement(id);
		root.appendChild(echild);
		tchild = document.createTextNode(text);
		echild.appendChild(tchild);

		return echild;
	}

	/**
	 * 하위에 문자열을 추가
	 * @param Document document XML데이터
	 * @prarm Element rt 추가 위치
	 * @param id 생성될 Element의 ID
	 * @param text Element 하위에 들어갈 문자열
	 * @return Element element 추가된 Element
	 * @exception Exception
	*/
	public static Text insertText(Document document, Element rt, String text) throws Exception {

		Text tchild = null;
		Element root = null;

		if (rt == null) {
			root = getRootElement(document);
		} else {
			root = rt;
		}
		tchild = document.createTextNode(text);
		root.appendChild(tchild);

		return tchild;
	}

	/**
	 * 마지막으로 입력되었거나 참조된 XML Node의 상위 Element를 리턴
	 * @prarm Element current 현재노드
	 * @return Element parent 상위노드
	 * @exception Exception
	*/
	public static Element getParentNode(Element current) throws Exception {

		Node parent = current.getParentNode();
		return (Element) parent;
	}

	/**
	 * Document 객체를 XML파일로 저장
	 * @param Document document 문서객체
	 * @param String fiile 저장될 파일
	 * @return boolean 저장여부 True / False
	 * @exception Exception
	*/
	public static boolean getXMLFile(Document document, String file) throws Exception {

		boolean retVal = false;

		String file1 = file.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(file1);
		if (srcFile.exists() && srcFile.isFile()) {

			Source source = new DOMSource(document);
			Result result = new StreamResult(srcFile);
			Transformer transformer = TransformerFactory.newInstance().newTransformer();
			transformer.setOutputProperty(OutputKeys.METHOD, "xml");
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.transform(source, result);
		}

		return retVal;
	}

	public static InputStream getXMLInputStream(Document document) throws TransformerFactoryConfigurationError, TransformerException {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		Transformer transformer = TransformerFactory.newInstance().newTransformer();
		transformer.setOutputProperty(OutputKeys.METHOD, "xml");
//		transformer.setOutputProperty(OutputKeys.INDENT, "yes");

		transformer.transform(new DOMSource(document), new StreamResult(outputStream));

		return new ByteArrayInputStream(outputStream.toByteArray());
	}

	public static Document getNewDoc() throws ParserConfigurationException {
		return DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
	}
}
