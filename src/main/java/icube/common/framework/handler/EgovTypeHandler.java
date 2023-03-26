package icube.common.framework.handler;

import java.io.BufferedReader;
import java.io.Reader;
import java.sql.Clob;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import icube.common.framework.helper.ResourceCloseHelper;

@SuppressWarnings("serial")
public class EgovTypeHandler extends EgovMap {

	@Override
	public Object put(Object key, Object value) {

		if (value instanceof Clob) {

			final StringBuilder sb = new StringBuilder();

			Reader reader = null;
			BufferedReader bufferedReader = null;

			try {
				reader = ((Clob) value).getCharacterStream();
				bufferedReader = new BufferedReader(reader);
				int b;
				while (-1 != (b = bufferedReader.read())) {
					sb.append((char) b);
				}
				value = sb.toString();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				ResourceCloseHelper.close(reader, bufferedReader);
			}
		}

		return super.put(key, value);
	}

}
