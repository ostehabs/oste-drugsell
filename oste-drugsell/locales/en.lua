local Translations = {
    error = {
        ["canceled"]                    = "Canceled",
    },
    weed = {
        ["need_money"] = "You don't have enough money. You need $500.",
        ["enough_weed"] = "You don't have enough hash. You need 70 bags.",
        ["ongoing"] = "Nope! You can't do that!",
        ["got_the_route"] = "You have received a GPS!",
        ["continue"] = "Do you want to continue selling?",
        ["stop_sell"] = "Thank you for your business.",
        ["deliver_again"] = "Deliver your product to one of my helpers.",
        ["wait_weed_collect_money"] = "Negotiating price...",
        ["wait_weed_give_product"] = "Agreeing on route...",
        ["wait_weed_start"] = "Agreeing on route...",
        ["quick_continue"]               = "Unknown",
        ["quick_got_the_route"]          = "Unknown",
        ["quick_stop_sell"]              = "Unknown",
        ["quick_deliver_again"]          = "Unknown",
        ["quick_need_money"]             = "Unknown",
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
