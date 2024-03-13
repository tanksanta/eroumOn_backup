<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/common/ckeditor.jsp"/>

				<form:form name="frmNtt" id="frmNtt" modelAttribute="nttVO" method="post" action="./action" enctype="multipart/form-data" class="form-horizontal">
					
                    <fieldset>
                        
                        <table class="table-detail">
                            <tbody>
                            	
								<tr>
                                    <td>
                                        <form:textarea path="cn" class="form-control w-full" title="내용" cols="30" rows="4" />
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </fieldset>

                </form:form>
