package icube.members.biz;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;

@Service("partnersService")
public class PartnersService extends CommonAbstractServiceImpl {

	@Resource(name="partnersDAO")
	private PartnersDAO partnersDAO;

}
