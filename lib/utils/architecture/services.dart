final services = <Type, dynamic>{};
void service<S>(S instance) {
  services[S] = instance;
}
