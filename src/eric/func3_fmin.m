function [r2,params,conc,conc2]=func3_fmin(params, ...
                                           initial_conditions, ...
                                           EGF_conc, ...
                                           inhib, ...
                                           time_course, ...
                                           te, ...
                                           tp, ...
                                           fract, ...
                                           tf, ...
                                           conc, ...
                                           conc2)

time_course_eq = 0:1:300;
tp_eq=1;te_eq=1;
[~, y_equilib, conc, conc2]=func2_TimeCourse(params,initial_conditions,0,[1,1], ...
                                             time_course_eq,te_eq,tp_eq,conc,conc2);
initial_conditions2=y_equilib(end,:);

num_points=numel(tf);
num_ep=numel(EGF_conc);
r = zeros(num_ep,num_points);
ERK = zeros(num_ep,1);
aERK = zeros(num_ep,1);

for ep=1:num_ep

    [~, y_vals, params, conc, conc2]=func2_TimeCourse(params,initial_conditions2, ...
                                                      EGF_conc(ep),inhib, ...
                                                      time_course,te,tp,conc,conc2);

    aERK(:,1)=y_vals(:,11);
    ERK(:,1)=y_vals(:,12);
    aERK_t=aERK(time_course==tf);
    ERK_t=ERK(time_course==tf);
    mod_fract=aERK_t./(aERK_t+ERK_t);
    r(ep,:)=mod_fract*100-fract(ep)*100;
    
%     for i=1:num_points
%         aERK_t=aERK(time_course==tf(i));
%         ERK_t=ERK(time_course==tf(i));
% 
%         mod_fract=aERK_t/(aERK_t+ERK_t);
% 
%         r(ep,i)=mod_fract*100-fract(ep)*100;
%     end
%     

end

r2=sum(sum(r.^2));

%mod_fract=y_vals(end,11)/(y_vals(end,11)+y_vals(end,12));
%r2=(mod_fract*100-fract*100)^2;
end
