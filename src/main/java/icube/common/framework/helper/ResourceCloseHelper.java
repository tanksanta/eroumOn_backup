package icube.common.framework.helper;

import java.io.Closeable;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Wrapper;

public class ResourceCloseHelper {
	/**
	 * Resource close 처리.
	 * @param resources
	 */
	public static void close(Closeable  ... resources) {
		for (Closeable resource : resources) {
			if (resource != null) {
				try {
					resource.close();
				} catch (IOException ignore) {
					ignore.printStackTrace();
				} catch (Exception ignore) {
					ignore.printStackTrace();
				}
			}
		}
	}

	/**
	 * JDBC 관련 resource 객체 close 처리
	 * @param objects
	 */
	public static void closeDBObjects(Wrapper ... objects) {
		for (Object object : objects) {
			if (object != null) {
				if (object instanceof ResultSet) {
					try {
						((ResultSet)object).close();
					} catch (SQLException ignore) {
						ignore.printStackTrace();
					} catch (Exception ignore) {
						ignore.printStackTrace();
					}
				} else if (object instanceof Statement) {
					try {
						((Statement)object).close();
					} catch (SQLException ignore) {
						ignore.printStackTrace();
					} catch (Exception ignore) {
						ignore.printStackTrace();
					}
				} else if (object instanceof Connection) {
					try {
						((Connection)object).close();
					} catch (SQLException ignore) {
						ignore.printStackTrace();
					} catch (Exception ignore) {
						ignore.printStackTrace();
					}
				} else {
					throw new IllegalArgumentException("Wrapper type is not found : " + object.toString());
				}
			}
		}
	}

	/**
	 * Socket 관련 resource 객체 close 처리
	 * @param objects
	 */
	public static void closeSocketObjects(Socket socket, ServerSocket server) {
		if (socket != null) {
			try {
				socket.shutdownOutput();
			} catch (IOException ignore) {
				ignore.printStackTrace();
			} catch (Exception ignore) {
				ignore.printStackTrace();
			}

			try {
				socket.close();
			} catch (IOException ignore) {
				ignore.printStackTrace();
			} catch (Exception ignore) {
				ignore.printStackTrace();
			}
		}

		if (server != null) {
			try {
				server.close();
			} catch (IOException ignore) {
				ignore.printStackTrace();
			} catch (Exception ignore) {
				ignore.printStackTrace();
			}
		}
	}

	/**
	 *  Socket 관련 resource 객체 close 처리
	 *
	 * @param sockets
	 */
	public static void closeSockets(Socket ... sockets) {
		for (Socket socket : sockets) {
			if (socket != null) {
				try {
					socket.shutdownOutput();
				} catch (IOException ignore) {
					ignore.printStackTrace();
				} catch (Exception ignore) {
					ignore.printStackTrace();
				}

				try {
					socket.close();
				} catch (IOException ignore) {
					ignore.printStackTrace();
				} catch (Exception ignore) {
					ignore.printStackTrace();
				}
			}
		}
	}
}