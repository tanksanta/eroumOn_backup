<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	                    <div class="card-content box_coun_list pad20">
	
	                        <div class="img_area
                        	<c:choose>
                        		<%-- 복지용구 상담 이미지 --%>
                        		<c:when test="${consltInfo.prevPath eq 'equip_ctgry'}"> trans_02</c:when>
                        		<%-- 간편테스트, 돌봄 상담 이미지 --%>
                        		<c:otherwise> trans_01</c:otherwise>
                        	</c:choose> 
                        	<c:choose>
                        		<%-- 상담완료, 취소 회색 배경 --%>
                        		<c:when test="${consltInfo.consltSttus eq 'CS06' || isCancelConslt}"> ok</c:when>
                        		<%-- 상담중 청색 배경 --%>
                        		<c:otherwise> ing</c:otherwise>
                        	</c:choose>">
	                            <span class="txt font_sss">
	                            	<c:choose>
	                            		<c:when test="${consltInfo.consltSttus eq 'CS01' || consltInfo.consltSttus eq 'CS07'}">
	                            			신청완료
	                            		</c:when>
	                            		<c:when test="${consltInfo.consltSttus eq 'CS02' || consltInfo.consltSttus eq 'CS08'}">
	                            			상담<br>연결중
	                            		</c:when>
	                            		<c:when test="${consltInfo.consltSttus eq 'CS05'}">
	                            			상담<br>진행중
	                            		</c:when>
	                            		<c:when test="${consltInfo.consltSttus eq 'CS06'}">
	                            			상담완료
	                            		</c:when>
	                            		<c:otherwise>
	                            			상담취소
	                            		</c:otherwise>
	                            	</c:choose>
	                            </span>
	                        </div>
	
	                        <div>
	                            <div class="font_sblb">${prevPathMap[consltInfo.prevPath]}</div>
	                            <div class="marT4">
	                                <span class="color_t_s font_sbsr">${prevPathCtgryMap[consltInfo.prevPath]}</span>
	                                <span class="marL4 color_t_s font_sbsr">
	                                	<fmt:formatDate value="${consltInfo.regDt}" pattern="yyyy.MM.dd" />
	                                </span>
	                            </div>
	                        </div>
	
	                    </div>