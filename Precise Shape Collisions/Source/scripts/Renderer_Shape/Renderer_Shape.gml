//  @function				Renderer_Shape()
/// @description			Shape rendering and input operator.
function Renderer_Shape() : Instance() constructor
{
  #region [Events]
		
	static createEvent = function()
	{
		configuration = struct
		{
			color = struct
			{
				var _fill_color = [make_color_rgb(255, 80, 0), make_color_rgb(255, 110, 40)];
				
				fill = [new Color2(_fill_color[0], _fill_color[1]),
						new Color3(_fill_color[0], _fill_color[1], _fill_color[1]),
						new Color4(_fill_color[0], _fill_color[0], _fill_color[1], _fill_color[1])];
				
				outline = struct
				{
					inactive = new Color2(c_aqua, c_fuchsia);
					active = new Color2(make_color_rgb(100, 255, 255), c_red);
				};
			};
			
			outline = struct
			{
				size = 30;
			};
			
			speed = struct
			{
				transition = 0.05;
			};
		}
		
		state = struct
		{
			transition = struct
			{
				percentage = [];
			};
		};
		
		shape =
		[
			new RoundRectangle(new Vector4(150, 100, 450, 250), new Vector2(50),
							   configuration.color.fill[2], 1, configuration.outline.size, undefined,
							   1, 40),
			new Line(new Vector4(600, 150, 750, 300), 50, configuration.color.fill[2], 1,
					 configuration.outline.size, undefined, 1),
			new Ellipse(new Vector4(150, 350, 450, 500), configuration.color.fill[0], 1,
						configuration.outline.size, undefined, 1, 64),
			new Triangle(new Vector2(600, 420), new Vector2(530, 540), new Vector2(670, 540),
						 configuration.color.fill[1], 1, 2, undefined, 1)
		];
		
		var _shape_count = array_length(shape);
		state.transition.percentage = array_create(_shape_count, undefined);
		var _i = 0;
		repeat (_shape_count)
		{
			state.transition.percentage[_i] = new RangedValue(Range.one);
			
			++_i;
		}
	}
	
	static stepEvent = function()
	{
		var _color = configuration.color.outline;
		var _i = 0;
		repeat (array_length(shape))
		{
			var _shape_current = shape[_i];
			var _transition_current = state.transition.percentage[_i];
			var _shape_active = (_shape_current.cursorOver(undefined, undefined, true));
			
			_transition_current.modify(sign_bool(_shape_active) * configuration.speed.transition);
			_shape_current.outline_color = _color.inactive.interpolate(_color.active,
																	   _transition_current.value);
			
			++_i;
		}
	}
	
	static drawEvent = function()
	{
		var _i = 0;
		repeat (array_length(shape))
		{
			shape[_i].render();
			
			++_i;
		}
	}
		
  #endregion
}
