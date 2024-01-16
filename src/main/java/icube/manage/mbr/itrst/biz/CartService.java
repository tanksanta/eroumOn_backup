package icube.manage.mbr.itrst.biz;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.string.EgovStringUtil;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.vo.CommonListVO;
import icube.manage.gds.gds.biz.GdsVO;
import icube.manage.gds.optn.biz.GdsOptnService;
import icube.manage.gds.optn.biz.GdsOptnVO;
import icube.manage.sysmng.entrps.biz.EntrpsDlvyGrpVO;
import icube.manage.sysmng.entrps.biz.EntrpsVO;

@Service("cartService")
public class CartService extends CommonAbstractServiceImpl {

	@Resource(name="cartDAO")
	private CartDAO cartDAO;

	@Resource(name = "gdsOptnService")
	private GdsOptnService gdsOptnService;

	public CommonListVO selectMbrCartListVO(CommonListVO listVO) throws Exception {
		return cartDAO.selectMbrCartListVO(listVO);
	}

	public List<EntrpsDlvyGrpVO> selectCartDlvygrpListAll(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartDlvygrpListAll(paramMap);
	}

	public List<EntrpsVO> selectCartEntrpsListAll(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartEntrpsListAll(paramMap);
	}

	public List<CartVO> selectCartListAll(Map<String, Object> paramMap) throws Exception {
		List<CartVO> list = cartDAO.selectCartListAll(paramMap);

		if (paramMap.get("reCalcPcYn") != null && EgovStringUtil.equals("Y", paramMap.get("reCalcPcYn").toString())){

			int ifor, ilen = list.size();
			CartVO cartVO;
			int ordrQy, gdsPc, ordrOptnPc, gdsOptnPc;
			List<GdsOptnVO> optnList;
			for(ifor=0 ; ifor<ilen; ifor++){
				cartVO = list.get(ifor);
				gdsOptnPc = 0;

				optnList = null;
				if (cartVO.getGdsInfo() != null){
					final int gdsOptnNo = cartVO.getGdsOptnNo();
					if (EgovStringUtil.equals("ADIT", cartVO.getOrdrOptnTy())){
						gdsPc = 0;
						optnList = cartVO.getGdsInfo().getAditOptnList();
						
					}else{
						optnList = cartVO.getGdsInfo().getOptnList();
						
						if (cartVO.getGdsInfo().getDscntRt() > 0 && cartVO.getGdsInfo().getDscntPc() > 0 ){
							gdsPc = cartVO.getGdsInfo().getDscntPc();
						}else{
							gdsPc = cartVO.getGdsInfo().getPc();
						}
					}

					if (gdsOptnNo > 0 && optnList != null){
						GdsOptnVO optn = optnList.stream().filter(f -> f.getGdsOptnNo() == gdsOptnNo).findAny().orElse(null);
						if (optn != null) {
							gdsOptnPc = optn.getOptnPc();
						}
					}
					
					ordrOptnPc = cartVO.getOrdrOptnPc();
					ordrQy = cartVO.getOrdrQy();
					if (((gdsPc + ordrOptnPc) * ordrQy != cartVO.getOrdrPc()) || (ordrOptnPc != gdsOptnPc)){
						cartVO.setGdsPc(gdsPc);
						cartVO.setOrdrOptnPc(gdsOptnPc);
						cartVO.setOrdrPc((gdsPc + gdsOptnPc) * ordrQy);

						cartDAO.updateCartPc(cartVO);
					}
				}
			}

			// if (bChanged){
			// 	list = cartDAO.selectCartListAll(paramMap);
			// }
		}
		
		return list;
	}

	public CartVO selectCartByFilter(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartByFilter(paramMap);
	}
	public List<CartVO> selectCartByFilter2(Map<String, Object> paramMap) throws Exception {
		return cartDAO.selectCartByFilter2(paramMap);
	}

	public int insertCart(CartVO cartVO) throws Exception {
		return cartDAO.insertCart(cartVO);
	}

	public void deleteCart(Map<String, Object> paramMap) throws Exception {
		cartDAO.deleteCart(paramMap);
	}
	public void deleteCartOptn(Map<String, Object> paramMap) throws Exception {
		cartDAO.deleteCartOptn(paramMap);
	}

	public Integer modifyOptnChg(CartVO cartVO) throws Exception{
		return cartDAO.modifyOptnChg(cartVO);
	}

	public void deleteCartlByNos(String[] arrDelCartNo) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cartNos", arrDelCartNo);

		cartDAO.deleteCartlByNos(paramMap);
	}

	public void updateMbrCart(GdsVO gdsVO) throws Exception {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("srchGdsCode", gdsVO.getGdsCd());

		List<CartVO> cartList = selectCartListAll(paramMap);

		for(CartVO cartVO : cartList) {

			cartVO.setBnefCd(gdsVO.getBnefCd());
			cartVO.setGdsNm(gdsVO.getGdsNm());
			cartVO.setGdsPc(gdsVO.getPc());
			cartVO.setOrdrPc((gdsVO.getPc() +  cartVO.getOrdrOptnPc()) * cartVO.getOrdrQy());

			updateCart(cartVO);
		}
	}

	public void updateCart(CartVO cartVO) throws Exception {
		cartDAO.updateCart(cartVO);
	}
	public void updateCartQy(CartVO cartVO) throws Exception {
		cartDAO.updateCartQy(cartVO);
	}
}
