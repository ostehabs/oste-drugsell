local Translations = {
    error = {
        ["canceled"]                    = "Afbrudt",
    },
    weed = {
        ["wait_weed_start"]              = "Aftaler rute..",
        ["enough_weed"]                  = "Du har ikke nok Hash. Du skal bruge 70 Poser.",
        ["ongoing"]                      = "Niks! Det kan du ikke!",
        ["quick_got_the_route"]          = "Ukendt",
        ["got_the_route"]                = "Du har modtaget en GPS!",
        ["quick_continue"]               = "Ukendt",
        ["continue"]                     = "Vil du fortsæt med at sælge?",
        ["quick_stop_sell"]              = "Ukendt",
        ["stop_sell"]                    = "Tak for handlen.",
        ["quick_deliver_again"]          = "Ukendt",
        ["deliver_again"]                = "Aflever dit produkt til en af mine hjælpere.",
        ["quick_need_money"]             = "Ukendt",
        ["need_money"]                   = "Du har ikke nok penge. Du skal bruge 500$.",
        ["wait_weed_collect_money"]      = "Forhandler pris..",
        ["wait_weed_give_product"]       = "Aftaler rute..",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
