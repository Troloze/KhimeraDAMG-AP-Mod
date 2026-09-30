y += ((yDest - y) * 0.3);

if (abs(yDest - y) < 4)
    y = yDest;

if (global.Apress && canmove)
{
    if (pageIndex == 0 && global.ap_item_nme_obtained[indexSelected])
    {
        newPage = indexSelected;
        event_perform(ev_other, ev_user1);
    }
}

if (global.Upress && canmove)
{
    if (pageIndex == 0)
    {
        indexSelected -= 1;
        
        if ((indexSelected % pageLimit) == 0)
            indexSelected += pageLimit;
    }
}
else if (global.Dpress && canmove)
{
    if (pageIndex == 0)
    {
        indexSelected += 1;
        
        if ((indexSelected % pageLimit) == 1)
            indexSelected -= pageLimit;
    }
}
else if (global.Lpress && canmove)
{
    if (pageIndex == 0)
    {
        if (indexSelected > pageLimit)
            indexSelected -= pageLimit;
        else
            indexSelected += pageLimit;
    }
    else
    {
        indexSelected = pageIndex;
        newPage = pageIndex - 1;
        
        while (!global.ap_item_nme_obtained[newPage] && newPage > 0)
            newPage -= 1;
        
        event_perform(ev_other, ev_user1);
    }
}
else if (global.Rpress && canmove)
{
    if (pageIndex == 0)
    {
        if (indexSelected > pageLimit)
            indexSelected -= pageLimit;
        else
            indexSelected += pageLimit;
    }
    else
    {
        newPage = pageIndex;
        
        do
        {
            newPage += 1;
            
            if (newPage > indexChoices)
                newPage = 0;
        }
        until (global.ap_item_nme_obtained[newPage] || newPage == 0);
        
        event_perform(ev_other, ev_user1);
    }
}

if (indexSelected > indexChoices)
    indexSelected = indexChoices;

if (global.Spress && canmove)
{
    if (pageIndex == 0)
    {
        event_perform(ev_other, ev_user0);
    }
    else
    {
        indexSelected = pageIndex;
        newPage = 0;
        event_perform(ev_other, ev_user1);
    }
}

if (keyboard_check_pressed(vk_escape) && canmove)
    event_perform(ev_other, ev_user0);
