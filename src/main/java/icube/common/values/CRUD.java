package icube.common.values;

public enum CRUD {

	CREATE("C"), READ("R"), UPDATE("U"), DELETE("D"), ANSWER("A"), REPLY("RE");

	private String type;

	private CRUD(String type) {
		this.type = type;
	}

	public String getType() {
		return this.type;
	}
}
