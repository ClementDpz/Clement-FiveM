Config = {}

Config.Blips = {
    -- Blips légaux

    ["test"] = {        
        x = -1047.00,
        y = -395.00,
        z = 37.00,
        blipInfo = {
            title     = "Test",
            color     = 74,
            id        = 225,
            scale     = 0.7,
            jobCondition = {
                "police_nationale"
            }
        },
        markerInfo = {
            id        = 0,
            red       = 155,
            green     = 155,
            blue      = 155,
            alpha     = 255,
            scaleX    = 1,
            scaleY    = 1,
            scaleZ    = 1,
            message   = "Appuyez sur ~INPUT_CONTEXT~ ~s~",
            action    = "print('test')",
            jobCondition = {
                "police_nationale", 
                "sapeur_pompier" 
            },
            gangCondition = {
                "sukabra"
            }
        }
    }

    -- Blips Illégaux
}

-- AJOUTEZ GRADE EN CONDITION