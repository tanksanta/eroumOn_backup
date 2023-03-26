<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<div class="app-menu navbar-menu">
	<!-- LOGO -->
	<div class="navbar-brand-box">
		<!-- Dark Logo-->
		<a href="index.html" class="logo logo-dark"> <span class="logo-sm"> ICUBE-PMS <!-- <img src="/assets/images/logo-sm.png" alt="" height="22"> -->
		</span> <span class="logo-lg"> ICUBE-PMS <!-- <img src="/assets/images/logo-dark.png" alt="" height="17"> -->
		</span>
		</a>
		<!-- Light Logo-->
		<a href="index.html" class="logo logo-light"> <span class="logo-sm"> ICUBE-PMS <!-- <img src="/assets/images/logo-sm.png" alt="" height="22"> -->
		</span> <span class="logo-lg"> ICUBE-PMS <!-- <img src="/assets/images/logo-light.png" alt="" height="17"> -->
		</span>
		</a>
		<button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
			<i class="ri-record-circle-line"></i>
		</button>
	</div>

	<div id="scrollbar">
		<div class="container-fluid">

			<div id="two-column-menu"></div>
			<ul class="navbar-nav" id="navbar-nav">
				<li class="nav-item"><a class="nav-link menu-link" href="/dashboard/index?id=${param.id}"> <i class="ri-dashboard-2-line"></i> <span data-key="t-widgets">대쉬보드</span>
				</a></li>

				<li class="menu-title"><span data-key="t-menu">APP</span></li>

				<li class="nav-item"><a class="nav-link menu-link" href="/projects/project/list?id=${param.id}"> <i class="ri-apps-2-line"></i> <span data-key="t-apps">프로젝트</span>
				</a></li>
				<li class="nav-item"><a class="nav-link menu-link" href="#sidebarApps" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="sidebarApps"> <i class="ri-apps-2-line"></i> <span data-key="t-apps">일감</span>
				</a>
					<div class="collapse menu-dropdown" id="sidebarApps">
						<ul class="nav nav-sm flex-column">
								<li class="nav-item"><a href="/tickets/kanban/index?id=${param.id}" class="nav-link" data-key="t-kanbanboard"> Kanban Board </a></li>
										<li class="nav-item"><a href="/tasks/task/list?id=${param.id}" class="nav-link" data-key="t-list-view"> List</a></li>
						</ul></li>

				<li class="nav-item"><a class="nav-link menu-link" href="/tickets/ticket/list?id=${param.id}" > <i class="ri-apps-2-line"></i> <span data-key="t-apps">티켓</span>
				</a></li>

				<li class="menu-title"><span data-key="t-menu">Team</span></li>
				<li class="nav-item"><a class="nav-link menu-link" href="/team/list?id=${param.id}" > <i class="mdi mdi-human-male-male"></i> <span data-key="t-apps">팀원</span>
				</a></li>

				<li class="menu-title"><span data-key="t-menu">Sample</span></li>
				<a class="nav-link menu-link" href="/sample/list?id=${param.id}"> <i class="ri-apps-2-line"></i> <span>board</span>
				</a>
				</li>

			</ul>
		</div>
		<!-- Sidebar -->
	</div>

	<div class="sidebar-background"></div>
</div>
