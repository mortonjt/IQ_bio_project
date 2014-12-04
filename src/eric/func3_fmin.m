function r2=func3_fmin(params,initial_conditions,EGF_conc,inhib,time_course,te,tp,fract,tf)

time_course_eq = 0:1:300;
tp_eq=1;te_eq=1;
[time, y_equilib]=func2_TimeCourse(params,initial_conditions,0,[1,1],time_course_eq,te_eq,tp_eq);
initial_conditions2=y_equilib(end,:);


num_points=numel(tf);
num_exp=numel(EGF_conc);

for exp=1:num_exp

[time, y_vals]=func2_TimeCourse(params,initial_conditions2,EGF_conc(exp),inhib,time_course,te,tp);

aERK(:,1)=y_vals(:,11);
ERK(:,1)=y_vals(:,12);

for i=1:num_points
    aERK_t=aERK(find(time_course==tf(i)));
    ERK_t=ERK(find(time_course==tf(i)));
    
    mod_fract=aERK_t/(aERK_t+ERK_t);
    
    r(exp,i)=mod_fract*100-fract(exp)*100;
end

end

r2=sum(sum(r.^2));

%mod_fract=y_vals(end,11)/(y_vals(end,11)+y_vals(end,12));
%r2=(mod_fract*100-fract*100)^2;
end