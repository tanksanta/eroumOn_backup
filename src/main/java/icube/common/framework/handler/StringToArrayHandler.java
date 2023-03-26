package icube.common.framework.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@SuppressWarnings("rawtypes")
public class StringToArrayHandler implements TypeHandler {

	private static final Logger logger = LoggerFactory.getLogger(StringToArrayHandler.class);

	@Override
	public void setParameter(PreparedStatement ps, int i, Object parameter,
			JdbcType jdbcType) throws SQLException {
	}

	@Override
	public Object getResult(ResultSet rs, String columnName)
			throws SQLException {

		String str = rs.getString(columnName);
		String[] ary = null;
		try {
			if ( str == null || str.equals("") )
				return null;
			ary = str.split(",");
			for(int i = 0; i < ary.length; i++ ) {
				ary[i] = ary[i].trim();
			}
		} catch(Exception e) {
			logger.error(e.toString(), e);
		}
		return ary;
	}

	@Override
	public Object getResult(ResultSet rs, int columnIndex) throws SQLException {
		return null;
	}

	@Override
	public Object getResult(CallableStatement cs, int columnIndex) throws SQLException {
		return null;
	}


}
