function s = string_date_time()
    [y,mo,d] = ymd(datetime);
    [h,m,s] = hms(datetime);
    s = [ num2str(y) '-' num2str(mo) '-' num2str(d) '_' num2str(h) '-' num2str(m) '-' num2str(floor(s)) ];
end