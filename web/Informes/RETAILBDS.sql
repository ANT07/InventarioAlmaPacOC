USE [InventarioAlmaPacOC]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 23/02/2019 12:06:24 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[clientes](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombreCliente] [varchar](50) NOT NULL,
	[apellidoCliente] [varchar](50) NOT NULL,
	[direccionCliente] [varchar](250) NOT NULL,
	[telefonoCliente] [varchar](10) NOT NULL,
	[sexoCliente] [char](1) NOT NULL,
 CONSTRAINT [PK_clientes] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[compra]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[compra](
	[idCompra] [int] IDENTITY(1,1) NOT NULL,
	[fechaCompra] [datetime] NOT NULL,
	[totalCompra] [float] NOT NULL,
	[proveedor] [varchar](50) NOT NULL,
	[estado] [int] NOT NULL,
 CONSTRAINT [PK_compra] PRIMARY KEY CLUSTERED 
(
	[idCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONTACT]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTACT](
	[CONTACTID] [int] IDENTITY(1,1) NOT NULL,
	[CONTACTNAME] [varchar](250) NULL,
	[CONTACTSTATE] [int] NOT NULL,
	[PHONE] [varchar](50) NULL,
 CONSTRAINT [PK_CONTACT_1] PRIMARY KEY CLUSTERED 
(
	[CONTACTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DEPARTMENT]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DEPARTMENT](
	[DEPARTMENTID] [int] IDENTITY(1,1) NOT NULL,
	[DEPARTMENTNAME] [varchar](200) NULL,
	[DEPARTEMETSTATE] [int] NULL CONSTRAINT [DF_DEPARTMENT_DEPARTEMETSTATE]  DEFAULT ((1)),
 CONSTRAINT [PK_DEPARTMENT] PRIMARY KEY CLUSTERED 
(
	[DEPARTMENTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[detallecompra]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detallecompra](
	[idDetalleCompra] [int] IDENTITY(1,1) NOT NULL,
	[idCompra] [int] NOT NULL,
	[codigoProducto] [int] NOT NULL,
	[precioDetalle] [float] NOT NULL,
	[totalDetalle] [float] NOT NULL,
	[cantidadDetalle] [int] NOT NULL,
 CONSTRAINT [PK_detallecompra] PRIMARY KEY CLUSTERED 
(
	[idDetalleCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[detalleventa]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalleventa](
	[idDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[idVenta] [int] NOT NULL,
	[codigoProducto] [int] NOT NULL,
	[cantidadDetalle] [int] NOT NULL,
	[precioDetalle] [float] NOT NULL,
	[totalDetalle] [float] NOT NULL,
 CONSTRAINT [PK_detalleventa] PRIMARY KEY CLUSTERED 
(
	[idDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[menu]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[menu](
	[MENU_ID] [int] IDENTITY(1,1) NOT NULL,
	[MENU_NAME] [varchar](250) NOT NULL,
 CONSTRAINT [PK_menu] PRIMARY KEY CLUSTERED 
(
	[MENU_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ORDER_DETAIL]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ORDER_DETAIL](
	[ORDERDETAILID] [int] NOT NULL,
	[ORDERID] [varchar](50) NOT NULL,
	[PRODUCTID] [int] NULL,
	[ORDERDETAILQUANTITY] [real] NULL,
	[ORDERDETAILTOTAL] [real] NULL,
	[ORDERDETAILUNITPRICE] [real] NULL,
	[PRODUCTCOLOR] [varchar](50) NULL,
 CONSTRAINT [PK_ORDER_DETAIL] PRIMARY KEY CLUSTERED 
(
	[ORDERDETAILID] ASC,
	[ORDERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ORDER_MASTER]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ORDER_MASTER](
	[ORDERID] [varchar](50) NOT NULL,
	[DEPARTMENTID] [int] NOT NULL,
	[SELLERID] [int] NOT NULL,
	[TYPEID] [int] NOT NULL,
	[PROVIDERID] [int] NOT NULL,
	[ORDERDATE] [datetime] NULL,
	[ORDERCOMENT] [varchar](max) NULL,
	[ORDERTOTAL] [real] NULL,
 CONSTRAINT [PK_ORDER_MASTER] PRIMARY KEY CLUSTERED 
(
	[ORDERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ORDER_TYPE]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ORDER_TYPE](
	[TYPEID] [int] IDENTITY(1,1) NOT NULL,
	[TYPENAME] [varchar](50) NULL,
	[TYPESTATE] [int] NULL CONSTRAINT [DF_ORDER_TYPE_TYPESTATE]  DEFAULT ((1)),
 CONSTRAINT [PK_ORDER_TYPE] PRIMARY KEY CLUSTERED 
(
	[TYPEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[producto]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[producto](
	[codigoProducto] [int] IDENTITY(1,1) NOT NULL,
	[nombreProducto] [varchar](50) NOT NULL,
	[descripcionProducto] [varchar](250) NOT NULL,
	[precioProducto] [float] NOT NULL,
	[existenciaProducto] [int] NOT NULL,
 CONSTRAINT [PK_producto] PRIMARY KEY CLUSTERED 
(
	[codigoProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PROVIDER]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PROVIDER](
	[PROVIDERID] [int] IDENTITY(1,1) NOT NULL,
	[PROVIDERNAME] [varchar](200) NULL,
	[PROVIDERSTATE] [int] NOT NULL,
	[CONTACID] [int] NOT NULL,
 CONSTRAINT [PK_PROVIDER] PRIMARY KEY CLUSTERED 
(
	[PROVIDERID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[roll]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[roll](
	[ROLL_ID] [int] IDENTITY(1,1) NOT NULL,
	[ROLL_NAME] [varchar](250) NOT NULL,
 CONSTRAINT [PK_roll] PRIMARY KEY CLUSTERED 
(
	[ROLL_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[roll_submenu]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roll_submenu](
	[ROLL_SUBMENU_ID] [int] IDENTITY(1,1) NOT NULL,
	[ROLL_ID] [int] NULL,
	[SUMMENU_ID] [int] NULL,
	[ESTADO] [int] NOT NULL,
 CONSTRAINT [PK_roll_submenu] PRIMARY KEY CLUSTERED 
(
	[ROLL_SUBMENU_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sub_menu]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sub_menu](
	[SUMMENU_ID] [int] IDENTITY(1,1) NOT NULL,
	[SUBMENU_NAME] [varchar](250) NOT NULL,
	[URL] [varchar](250) NOT NULL,
	[MENU_ID] [int] NOT NULL,
 CONSTRAINT [PK_sub_menu] PRIMARY KEY CLUSTERED 
(
	[SUMMENU_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[USUARIO] [varchar](100) NOT NULL,
	[ROLL_ID] [int] NULL,
	[NOMBRE] [varchar](250) NULL,
	[CONTRASENA] [varchar](250) NULL,
	[ESTADOUSUARIO] [int] NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[USUARIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vendedor]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vendedor](
	[idVendedor] [int] IDENTITY(1,1) NOT NULL,
	[nombreVendedor] [varchar](50) NOT NULL,
	[apellidoVendedor] [varchar](50) NOT NULL,
	[direccionVendedor] [varchar](250) NOT NULL,
	[sexoVendedor] [char](1) NOT NULL,
	[telefonoVendedor] [varchar](10) NOT NULL,
	[duiVendedor] [varchar](15) NOT NULL,
 CONSTRAINT [PK_vendedor] PRIMARY KEY CLUSTERED 
(
	[idVendedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ventas]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ventas](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[fechaVenta] [datetime] NOT NULL,
	[totalVenta] [float] NOT NULL,
	[idVendedor] [int] NOT NULL,
	[idCliente] [int] NOT NULL,
	[estado] [int] NOT NULL,
 CONSTRAINT [PK_ventas] PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[clientes] ON 

INSERT [dbo].[clientes] ([idCliente], [nombreCliente], [apellidoCliente], [direccionCliente], [telefonoCliente], [sexoCliente]) VALUES (2, N'Johanna', N'Menjivar', N'Cumbres de San Bartolo', N'49894199', N'F')
SET IDENTITY_INSERT [dbo].[clientes] OFF
SET IDENTITY_INSERT [dbo].[compra] ON 

INSERT [dbo].[compra] ([idCompra], [fechaCompra], [totalCompra], [proveedor], [estado]) VALUES (1, CAST(N'2019-02-22 00:00:00.000' AS DateTime), 2500, N'insinca', 0)
INSERT [dbo].[compra] ([idCompra], [fechaCompra], [totalCompra], [proveedor], [estado]) VALUES (2, CAST(N'2019-02-22 00:00:00.000' AS DateTime), 2500, N'insinca', 0)
SET IDENTITY_INSERT [dbo].[compra] OFF
SET IDENTITY_INSERT [dbo].[CONTACT] ON 

INSERT [dbo].[CONTACT] ([CONTACTID], [CONTACTNAME], [CONTACTSTATE], [PHONE]) VALUES (1, N'MARIA SOLAIRE2', 1, N'99999999')
SET IDENTITY_INSERT [dbo].[CONTACT] OFF
SET IDENTITY_INSERT [dbo].[DEPARTMENT] ON 

INSERT [dbo].[DEPARTMENT] ([DEPARTMENTID], [DEPARTMENTNAME], [DEPARTEMETSTATE]) VALUES (2, N'MAYOREO', 0)
SET IDENTITY_INSERT [dbo].[DEPARTMENT] OFF
SET IDENTITY_INSERT [dbo].[detallecompra] ON 

INSERT [dbo].[detallecompra] ([idDetalleCompra], [idCompra], [codigoProducto], [precioDetalle], [totalDetalle], [cantidadDetalle]) VALUES (1, 1, 4, 50, 2500, 50)
INSERT [dbo].[detallecompra] ([idDetalleCompra], [idCompra], [codigoProducto], [precioDetalle], [totalDetalle], [cantidadDetalle]) VALUES (2, 2, 4, 50, 2500, 50)
SET IDENTITY_INSERT [dbo].[detallecompra] OFF
SET IDENTITY_INSERT [dbo].[menu] ON 

INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (1, N'Administracion')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (2, N'Productos')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (3, N'Vendedores')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (4, N'Clientes')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (5, N'Tipos de Orden')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (6, N'Departamentos')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (7, N'Proveedores')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (8, N'Ordenes de Compra')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (9, N'Ventas')
INSERT [dbo].[menu] ([MENU_ID], [MENU_NAME]) VALUES (10, N'Compras')
SET IDENTITY_INSERT [dbo].[menu] OFF
INSERT [dbo].[ORDER_DETAIL] ([ORDERDETAILID], [ORDERID], [PRODUCTID], [ORDERDETAILQUANTITY], [ORDERDETAILTOTAL], [ORDERDETAILUNITPRICE], [PRODUCTCOLOR]) VALUES (1, N'000001-19', 4, 1, 1, 1, N'001')
INSERT [dbo].[ORDER_DETAIL] ([ORDERDETAILID], [ORDERID], [PRODUCTID], [ORDERDETAILQUANTITY], [ORDERDETAILTOTAL], [ORDERDETAILUNITPRICE], [PRODUCTCOLOR]) VALUES (1, N'000002-19', 4, 50, 2500, 50, N'50')
INSERT [dbo].[ORDER_MASTER] ([ORDERID], [DEPARTMENTID], [SELLERID], [TYPEID], [PROVIDERID], [ORDERDATE], [ORDERCOMENT], [ORDERTOTAL]) VALUES (N'000001-19', 2, 2, 1002, 1, CAST(N'2019-02-19 00:00:00.000' AS DateTime), N'gsdrghdhrt', 1)
INSERT [dbo].[ORDER_MASTER] ([ORDERID], [DEPARTMENTID], [SELLERID], [TYPEID], [PROVIDERID], [ORDERDATE], [ORDERCOMENT], [ORDERTOTAL]) VALUES (N'000002-19', 2, 2, 1002, 1, CAST(N'2019-02-19 00:00:00.000' AS DateTime), N'purueba 2', 2500)
SET IDENTITY_INSERT [dbo].[ORDER_TYPE] ON 

INSERT [dbo].[ORDER_TYPE] ([TYPEID], [TYPENAME], [TYPESTATE]) VALUES (1002, N'LICITACION2', 0)
SET IDENTITY_INSERT [dbo].[ORDER_TYPE] OFF
SET IDENTITY_INSERT [dbo].[producto] ON 

INSERT [dbo].[producto] ([codigoProducto], [nombreProducto], [descripcionProducto], [precioProducto], [existenciaProducto]) VALUES (4, N'ANTHONY', N'agua para tomar', 1.5, 0)
SET IDENTITY_INSERT [dbo].[producto] OFF
SET IDENTITY_INSERT [dbo].[PROVIDER] ON 

INSERT [dbo].[PROVIDER] ([PROVIDERID], [PROVIDERNAME], [PROVIDERSTATE], [CONTACID]) VALUES (1, N'MARRISSA2333', 0, 1)
SET IDENTITY_INSERT [dbo].[PROVIDER] OFF
SET IDENTITY_INSERT [dbo].[roll] ON 

INSERT [dbo].[roll] ([ROLL_ID], [ROLL_NAME]) VALUES (1, N'admin')
SET IDENTITY_INSERT [dbo].[roll] OFF
SET IDENTITY_INSERT [dbo].[roll_submenu] ON 

INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1, 1, 1, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (2, 1, 2, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (3, 1, 3, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (4, 1, 4, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (6, 1, 6, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (7, 1, 7, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (8, 1, 8, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (9, 1, 9, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (10, 1, 10, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (12, 1, 12, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (13, 1, 15, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (14, 1, 16, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (15, 1, 17, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (16, 1, 18, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (17, 1, 19, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1017, 1, 1019, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1018, 1, 1020, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1019, 1, 1021, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1020, 1, 1022, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1021, 1, 1023, 1)
INSERT [dbo].[roll_submenu] ([ROLL_SUBMENU_ID], [ROLL_ID], [SUMMENU_ID], [ESTADO]) VALUES (1022, 1, 1024, 1)
SET IDENTITY_INSERT [dbo].[roll_submenu] OFF
SET IDENTITY_INSERT [dbo].[sub_menu] ON 

INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1, N'Menus de Aplicacion', N'/MenuView.jsp', 1)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (2, N'Rolles de Usuario', N'/RollView.jsp', 1)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (3, N'Usuarios de Aplicacion', N'/UserView.jsp', 1)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (4, N'Lista de Productos', N'/ListaProductos.jsp', 2)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (6, N'Lista de Vendedores', N'/ListaVendedores.jsp', 3)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (7, N'Insertar Vendedor', N'/InsertarVendedor.jsp', 3)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (8, N'Lista de Clientes', N'/ListaClientes.jsp', 4)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (9, N'Insertar Cliente', N'/InsertarClientes.jsp', 4)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (10, N'Insertar Producto', N'/InsertarProductos.jsp', 2)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (12, N'Insertar Tipo', N'/InsertarTipoOrden.jsp', 5)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (15, N'Lista de Tipos', N'/ListaTipos.jsp', 5)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (16, N'Lista de Departamentos', N'/ListaDepartamentos.jsp', 6)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (17, N'Lista de Proveedores', N'/ListaProveedores.jsp', 7)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (18, N'Insertar Departamento', N'/InsertarDepartamento.jsp', 6)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (19, N'Insertar Proveedor', N'/InsertarProveedor.jsp', 7)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1019, N'Lista de Ordenes', N'/OrdersView.jsp', 8)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1020, N'Insertar Orden', N'/NewOrderView.jsp', 8)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1021, N'Lista de Ventas', N'/ListaVentas.jsp', 9)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1022, N'Nueva Venta', N'/InsertarVenta.jsp', 9)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1023, N'Lista de Compras', N'/ListaCompras.jsp', 10)
INSERT [dbo].[sub_menu] ([SUMMENU_ID], [SUBMENU_NAME], [URL], [MENU_ID]) VALUES (1024, N'Nueva Compra', N'/InsertarCompra.jsp', 10)
SET IDENTITY_INSERT [dbo].[sub_menu] OFF
INSERT [dbo].[usuario] ([USUARIO], [ROLL_ID], [NOMBRE], [CONTRASENA], [ESTADOUSUARIO]) VALUES (N'admin', 1, N'Anthony', N'7196', 1)
SET IDENTITY_INSERT [dbo].[vendedor] ON 

INSERT [dbo].[vendedor] ([idVendedor], [nombreVendedor], [apellidoVendedor], [direccionVendedor], [sexoVendedor], [telefonoVendedor], [duiVendedor]) VALUES (2, N'ANTHONY', N'MARTINEZ', N'Cumbres de San Bartolo', N'F', N'22222222', N'549925455')
SET IDENTITY_INSERT [dbo].[vendedor] OFF
ALTER TABLE [dbo].[detallecompra]  WITH CHECK ADD  CONSTRAINT [detallecompra_ibfk_1] FOREIGN KEY([idCompra])
REFERENCES [dbo].[compra] ([idCompra])
GO
ALTER TABLE [dbo].[detallecompra] CHECK CONSTRAINT [detallecompra_ibfk_1]
GO
ALTER TABLE [dbo].[detallecompra]  WITH CHECK ADD  CONSTRAINT [detallecompra_ibfk_2] FOREIGN KEY([codigoProducto])
REFERENCES [dbo].[producto] ([codigoProducto])
GO
ALTER TABLE [dbo].[detallecompra] CHECK CONSTRAINT [detallecompra_ibfk_2]
GO
ALTER TABLE [dbo].[detalleventa]  WITH CHECK ADD  CONSTRAINT [detalleventa_ibfk_1] FOREIGN KEY([idVenta])
REFERENCES [dbo].[ventas] ([idVenta])
GO
ALTER TABLE [dbo].[detalleventa] CHECK CONSTRAINT [detalleventa_ibfk_1]
GO
ALTER TABLE [dbo].[detalleventa]  WITH CHECK ADD  CONSTRAINT [detalleventa_ibfk_2] FOREIGN KEY([codigoProducto])
REFERENCES [dbo].[producto] ([codigoProducto])
GO
ALTER TABLE [dbo].[detalleventa] CHECK CONSTRAINT [detalleventa_ibfk_2]
GO
ALTER TABLE [dbo].[ORDER_DETAIL]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_DETAIL_ORDER_MASTER] FOREIGN KEY([ORDERID])
REFERENCES [dbo].[ORDER_MASTER] ([ORDERID])
GO
ALTER TABLE [dbo].[ORDER_DETAIL] CHECK CONSTRAINT [FK_ORDER_DETAIL_ORDER_MASTER]
GO
ALTER TABLE [dbo].[ORDER_DETAIL]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_DETAIL_producto] FOREIGN KEY([PRODUCTID])
REFERENCES [dbo].[producto] ([codigoProducto])
GO
ALTER TABLE [dbo].[ORDER_DETAIL] CHECK CONSTRAINT [FK_ORDER_DETAIL_producto]
GO
ALTER TABLE [dbo].[ORDER_MASTER]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_MASTER_DEPARTMENT] FOREIGN KEY([DEPARTMENTID])
REFERENCES [dbo].[DEPARTMENT] ([DEPARTMENTID])
GO
ALTER TABLE [dbo].[ORDER_MASTER] CHECK CONSTRAINT [FK_ORDER_MASTER_DEPARTMENT]
GO
ALTER TABLE [dbo].[ORDER_MASTER]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_MASTER_ORDER_TYPE] FOREIGN KEY([TYPEID])
REFERENCES [dbo].[ORDER_TYPE] ([TYPEID])
GO
ALTER TABLE [dbo].[ORDER_MASTER] CHECK CONSTRAINT [FK_ORDER_MASTER_ORDER_TYPE]
GO
ALTER TABLE [dbo].[ORDER_MASTER]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_MASTER_PROVIDER] FOREIGN KEY([PROVIDERID])
REFERENCES [dbo].[PROVIDER] ([PROVIDERID])
GO
ALTER TABLE [dbo].[ORDER_MASTER] CHECK CONSTRAINT [FK_ORDER_MASTER_PROVIDER]
GO
ALTER TABLE [dbo].[ORDER_MASTER]  WITH CHECK ADD  CONSTRAINT [FK_ORDER_MASTER_vendedor] FOREIGN KEY([SELLERID])
REFERENCES [dbo].[vendedor] ([idVendedor])
GO
ALTER TABLE [dbo].[ORDER_MASTER] CHECK CONSTRAINT [FK_ORDER_MASTER_vendedor]
GO
ALTER TABLE [dbo].[PROVIDER]  WITH CHECK ADD  CONSTRAINT [FK_PROVIDER_CONTACT] FOREIGN KEY([CONTACID])
REFERENCES [dbo].[CONTACT] ([CONTACTID])
GO
ALTER TABLE [dbo].[PROVIDER] CHECK CONSTRAINT [FK_PROVIDER_CONTACT]
GO
ALTER TABLE [dbo].[roll_submenu]  WITH CHECK ADD  CONSTRAINT [FK_ROLL_SUB_RELATIONS_ROLL] FOREIGN KEY([ROLL_ID])
REFERENCES [dbo].[roll] ([ROLL_ID])
GO
ALTER TABLE [dbo].[roll_submenu] CHECK CONSTRAINT [FK_ROLL_SUB_RELATIONS_ROLL]
GO
ALTER TABLE [dbo].[roll_submenu]  WITH CHECK ADD  CONSTRAINT [FK_ROLL_SUB_RELATIONS_SUB_MENU] FOREIGN KEY([SUMMENU_ID])
REFERENCES [dbo].[sub_menu] ([SUMMENU_ID])
GO
ALTER TABLE [dbo].[roll_submenu] CHECK CONSTRAINT [FK_ROLL_SUB_RELATIONS_SUB_MENU]
GO
ALTER TABLE [dbo].[sub_menu]  WITH CHECK ADD  CONSTRAINT [fk_sub_menu_menu1] FOREIGN KEY([MENU_ID])
REFERENCES [dbo].[menu] ([MENU_ID])
GO
ALTER TABLE [dbo].[sub_menu] CHECK CONSTRAINT [fk_sub_menu_menu1]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD  CONSTRAINT [FK_USUARIO_RELATIONS_ROLL] FOREIGN KEY([ROLL_ID])
REFERENCES [dbo].[roll] ([ROLL_ID])
GO
ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_USUARIO_RELATIONS_ROLL]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [ventas_ibfk_1] FOREIGN KEY([idCliente])
REFERENCES [dbo].[clientes] ([idCliente])
GO
ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [ventas_ibfk_1]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [ventas_ibfk_2] FOREIGN KEY([idVendedor])
REFERENCES [dbo].[vendedor] ([idVendedor])
GO
ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [ventas_ibfk_2]
GO
/****** Object:  StoredProcedure [dbo].[ORDERREPORT2]    Script Date: 23/02/2019 12:06:27 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ORDERREPORT2]
	@ORDERID VARCHAR(50)
AS
BEGIN 
	select 
	ORDER_MASTER.ORDERID,
	PROVIDER.PROVIDERNAME,
	CONTACT.CONTACTNAME,
	CONTACT.PHONE,
	vendedor.nombreVendedor as SELLERNAME,
	ORDER_TYPE.TYPENAME,
	ORDER_MASTER.ORDERCOMENT,
	ORDER_MASTER.ORDERDATE,
	DEPARTMENT.DEPARTMENTNAME,
	SUBTOTAL = ORDER_MASTER.ORDERTOTAL,
	IVA = ORDER_MASTER.ORDERTOTAL * 0.13,
	TOTAL = (ORDER_MASTER.ORDERTOTAL * 0.13) + ORDER_MASTER.ORDERTOTAL
FROM
	PROVIDER,
	ORDER_MASTER,
	CONTACT,
	vendedor,
	ORDER_TYPE,
	DEPARTMENT
WHERE
	PROVIDER.CONTACID = CONTACT.CONTACTID AND
	ORDER_MASTER.PROVIDERID = PROVIDER.PROVIDERID AND
	ORDER_MASTER.SELLERID = vendedor.idVendedor AND
	ORDER_MASTER.TYPEID = ORDER_TYPE.TYPEID AND
	ORDER_MASTER.DEPARTMENTID = DEPARTMENT.DEPARTMENTID
	AND ORDER_MASTER.ORDERID = @ORDERID


END

GO
