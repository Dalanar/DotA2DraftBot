draft_cm = require(GetScriptDirectory()..'/CM/handle')


function Think()
    if (GetGameMode() == GAMEMODE_CM) then
        draft_cm.Handle()
    else
        print('Other mode launched, bypass')
    end
end
