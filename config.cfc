component 
	output="false"
	hint="config info"
	{
// PROD ENV
paramcfg = {
    'Env' ="prod",
    'dsn' = "prod"   
};

authcfg = {
    'levels' = {
        'guest' = '0',
        'inq' = '10',
        'user' = '20',
        'supper' = '30',
        'admin' = '90'
    },
    'auth' = {
        'admin' = [
            '/users/index',
            '/users/create',
            '/users/delete/*',
            '/users/edit/*',
            '/authors/delete/*',
            '/authors/edit/*',
            '/books/delete/*',
            '/books/edit/*'
        ],
        'user' = [
            "_MVCLOGOUT"
        ]
    }
}; 
routecfg = {
    'page404' = "notfound",
    'routes' = {
        'default_controller' = 'front',
        'alias' = {
            'mya' = ['contacts', 'usefullinks'], 
            'users' = ["login", "logout", "register", "weblogin", "winlogin"]
        }
    }
};

menucfg = {
    'menu' = {
        'main' = [
            {'title' = 'Home', 'path' = '/'},
            {'title' = 'Front', 'path' = '/front/index'},
            {'title' = 'Register', 'path' = "_MVCREGISTER"},
            {'title' = 'Login', 'path' = "_MVCLOGIN"},
            {'title' = 'Logout', 'path' = "_MVCLOGOUT"}
        ],
        'cmenu' = {
            'front' = [
                {'title'='Front','path'='/front/index'},
                {'title'='About','path'='/front/about'}
            ],
            'daskboard' = [
                {'title'='Home','path'='/'},
                {'title' = 'Dashboard', 'path' = '/dashboard/index'}
            ]        
        },
        'submenu' = {
            'front' = [
                {'title'='Books List','path'='/books/index'},
                {'title'='Authors List','path'='/authors/index'},
                {'title'= 'Users', 'path'='/users/index'},
                {'title' = 'Pages', 'path' = '/pages/index'},
                {'title' = 'Mya', 'path' = '/mya/index'},
                {'title' = 'Plain', 'path' = '/plain/index'}
            ],
            'user' = [
                {'title'='List','path'='/users/index'},
                {'title'='Create new user','path'='/users/create'}
            ],
            'mya' = [
                {'title'='Contacts','path'='/mya/contacts'},
                {'title'='Userful Links','path'='/mya/usefullinks'}
            ],
            'page' = [
                {'title' = 'Pages 1','path' = '/pages/page1'},
                {'title' = 'Pages 2','path' = '/pages/page2'}
            ],
            'daskboard' = [
                {'title'='Home','path'='/'},
                {'title' = 'Dashboard', 'path' = '/dashboard/index'}
            ]       
        }
        
    }
};
}