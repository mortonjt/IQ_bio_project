function [time, y_vals, params, conc, conc2]=func2_TimeCourse(params, ...
                                                              initial_conditions, ...
                                                              EGF_conc, ...
                                                              inhib, ...
                                                              time_course, ...
                                                              te, ...
                                                              tp, ...
                                                              conc, ...
                                                              conc2)

    %global p_mine conc conc2
    %p_mine=params;
    EGF_cell=0;

    y=zeros(numel(time_course)-1,length(initial_conditions)); %species concentrations over time

    y(1,:)=initial_conditions;
    %time=[];y_all=[];
    time = zeros(1,numel(time_course)-1);
    y_all = zeros(numel(time_course)-1,length(initial_conditions));

    for t=1:numel(time_course)-1
        %if time_course(t)==tp
            %y(t,:)=y(t,:)+pert;
        %end
        %time of egf addition
        if time_course(t)>te
            EGF_cell=EGF_conc;
        end
        %time of perturbation
        if time_course(t)>tp
            %parameters change upon inhibitor addition
            conc2(inhib(1))=conc(inhib(1),inhib(2));
        end

        options=odeset('NonNegative',1:25);
        %[time_now, y_now]=ode45(@func_ODEs,t:t+1,y(t,:),conc2,params,options);
        [time_now, y_now]=ode45(@(T,Y) func_ODEs(T,Y,conc2,params),t:t+1,y(t,:),options);
        %time=[time;time_now];
        %y_all=[y_all;y_now];
        time(t) = time_now(1);
        y_all(t,:) = y_now(1,:);
        y_cor=y_now;
        %y_cor(y_cor<0)=0;
        %% 17 = 17th species. EGFl
        if y_cor(end,17)<EGF_cell
            y_cor(end,17)=EGF_cell;
        end %correction

        y(t+1,:)=y_cor(end,:);
    end

    y_vals=y;

end


