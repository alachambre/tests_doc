package application

@Field ApplicationDescriptor application
@Field ResourceBundle messages

section 5, messages.getString('navigation')
newLine()

//Transform menu tree into a list of menu names, use asciidoc Menu macro for sub menus
def menus = application.menus.collect { Menu menu ->
                if(menu.page) {
                    return [menu.name]
                }else {
                    return menu.subMenus.collect{ Menu subMenu ->
                        return "menu:$menu.name[$subMenu.name]"
                    }
                }
            }.flatten()
            
//Transform menu tree into a list pages
def pages = application.menus.collect { Menu menu ->
                if(menu.page) {
                    return [menu.page.displayName]
                }else {
                    return menu.subMenus.collect{ Menu subMenu ->
                        return subMenu.page.displayName
                    }
                }
            }.flatten()

write new Table(headers: [
                    messages.getString('menu'),
                    messages.getString('applicationPage')
                ],
                columnsFormat: ["2a", "1"],
                columms: [menus, pages])

newLine()