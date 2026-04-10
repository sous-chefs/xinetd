# xinetd_install

Installs or removes the `xinetd` package.

## Actions

| Action     | Description                               |
|------------|-------------------------------------------|
| `:install` | **Default.** Installs the xinetd package. |
| `:remove`  | Removes the xinetd package.               |

## Properties

| Property       | Type     | Default    | Description                               |
|----------------|----------|------------|-------------------------------------------|
| `package_name` | `String` | `'xinetd'` | Name of the package to install or remove. |

## Examples

### Install xinetd with defaults

```ruby
xinetd_install 'default'
```

### Install with a custom package name

```ruby
xinetd_install 'xinetd' do
  package_name 'xinetd-nox'
end
```

### Remove xinetd

```ruby
xinetd_install 'xinetd' do
  action :remove
end
```
