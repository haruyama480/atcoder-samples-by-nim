from jinja2 import Environment, FileSystemLoader


class Template:
    def __init__(self, template_dir):
        self.env = Environment(loader=FileSystemLoader(template_dir))
        self.cpp_file = 'x.cpp'
        self.shell_file = 'exec.sh'

    def render_cpp(self, path, task_name, url, date):
        template = self.env.get_template(self.cpp_file)
        data = {
            'task_name': task_name,
            'url': url,
            'date': date,
        }
        content = template.render(data)

        with open(path, 'w+') as f:
            f.write(content)

    def render_shell(self, path):
        template = self.env.get_template(self.shell_file)
        content = template.render()

        with open(path, 'w+') as f:
            f.write(content)


class TemplateRs:
    def __init__(self, template_dir):
        self.env = Environment(loader=FileSystemLoader(template_dir))
        self.rs_file = 'x.rs'
        self.toml_file = 'x.toml'

    def render_rs(self, path, task_name, url):
        template = self.env.get_template(self.rs_file)
        data = {
            'task_name': task_name,
            'url': url,
        }
        content = template.render(data)

        with open(path, 'w+') as f:
            f.write(content)

    def render_toml(self, path, filenames):
        template = self.env.get_template(self.toml_file)
        data = {
            'filenames': filenames,
        }
        content = template.render(data)

        with open(path, 'w+') as f:
            f.write(content)


class TemplateNim:
    def __init__(self, template_dir):
        self.env = Environment(loader=FileSystemLoader(template_dir))
        self.nim_file = 'x.nim'
        self.cfg_file = 'nim.cfg'

    def render_nim(self, path, task_name, url):
        template = self.env.get_template(self.nim_file)
        data = {
            'task_name': task_name,
            'url': url,
        }
        content = template.render(data)

        with open(path, 'w+') as f:
            f.write(content)

    def render_cfg(self, path):
        template = self.env.get_template(self.cfg_file)
        data = {}
        content = template.render(data)

        with open(path, 'w+') as f:
            f.write(content)


if __name__ == '__main__':
    # ```
    # % python3 -i template.py
    # >>> t.render_toml('hoge.toml', ['aaa','bbb'])
    # ```
    t = TemplateRs('templates')
