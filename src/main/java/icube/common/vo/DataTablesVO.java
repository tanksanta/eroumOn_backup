package icube.common.vo;

import java.util.List;

/**
 * Datatable을 Ajax로 사용하기 위한 Response용 VO
 *
 * @lombok 사용시 object명이 변경되어 일반적인 get/set 사용
 */
//@Getter
//@Setter
public class DataTablesVO<T> {

	private String sEcho;
	private String sColumns;

	private int iTotalRecords;	//전체 레코드수
	private int iTotalDisplayRecords; // 필터링후의 전체 레코드수(i.e. 필터링 적용후의 레코드수,  해당 리절트셋의 리턴된 레코드수가 아님)

	private List<T> aaData;


	public String getsEcho() {
		return sEcho;
	}

	public void setsEcho(String sEcho) {
		this.sEcho = sEcho;
	}

	public String getsColumns() {
		return sColumns;
	}

	public void setsColumns(String sColumns) {
		this.sColumns = sColumns;
	}

	public int getiTotalRecords() {
		return iTotalRecords;
	}

	public void setiTotalRecords(int iTotalRecords) {
		this.iTotalRecords = iTotalRecords;
	}

	public int getiTotalDisplayRecords() {
		return iTotalDisplayRecords;
	}

	public void setiTotalDisplayRecords(int iTotalDisplayRecords) {
		this.iTotalDisplayRecords = iTotalDisplayRecords;
	}

	public List<T> getAaData() {
		return aaData;
	}

	public void setAaData(List<T> aaData) {
		this.aaData = aaData;
	}

}
