/* ============================================
   JavaScript Principal - SQL Server desde Cero
   ============================================ */

// Esperar a que el DOM esté cargado
document.addEventListener('DOMContentLoaded', function() {
    
    // Toggle del menú móvil
    const navToggle = document.getElementById('navToggle');
    const navMenu = document.getElementById('navMenu');
    
    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            
            // Animación del icono hamburguesa
            const spans = navToggle.querySelectorAll('span');
            if (navMenu.classList.contains('active')) {
                spans[0].style.transform = 'rotate(45deg) translate(5px, 5px)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'rotate(-45deg) translate(7px, -6px)';
            } else {
                spans[0].style.transform = '';
                spans[1].style.opacity = '';
                spans[2].style.transform = '';
            }
        });
        
        // Cerrar menú al hacer click en un enlace
        const navLinks = navMenu.querySelectorAll('a');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                navMenu.classList.remove('active');
                const spans = navToggle.querySelectorAll('span');
                spans[0].style.transform = '';
                spans[1].style.opacity = '';
                spans[2].style.transform = '';
            });
        });
    }
    
    // Smooth scroll para enlaces internos
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href');
            
            if (targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                const headerOffset = 80;
                const elementPosition = targetElement.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
                
                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Efecto de scroll en el header
    let lastScroll = 0;
    const header = document.querySelector('.header');
    
    window.addEventListener('scroll', function() {
        const currentScroll = window.pageYOffset;
        
        if (currentScroll > 100) {
            header.style.background = 'rgba(30, 30, 30, 0.98)';
            header.style.backdropFilter = 'blur(10px)';
        } else {
            header.style.background = 'var(--dark-bg)';
            header.style.backdropFilter = 'none';
        }
        
        lastScroll = currentScroll;
    });
    
    // Animación de aparición al hacer scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    // Observar elementos para animación
    const animatedElements = document.querySelectorAll('.content-card, .topic-card, .example-card, .component-card');
    
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
    
    // Highlight de código
    const codeBlocks = document.querySelectorAll('code.language-sql');
    
    codeBlocks.forEach(block => {
        const sql = block.textContent;
        
        // Palabras clave de SQL
        const keywords = [
            'SELECT', 'FROM', 'WHERE', 'INSERT', 'UPDATE', 'DELETE',
            'CREATE', 'DATABASE', 'TABLE', 'INDEX', 'VIEW',
            'ALTER', 'DROP', 'TRUNCATE',
            'JOIN', 'INNER', 'LEFT', 'RIGHT', 'FULL', 'OUTER', 'ON',
            'GROUP BY', 'ORDER BY', 'HAVING',
            'AND', 'OR', 'NOT', 'IN', 'BETWEEN', 'LIKE', 'IS NULL',
            'AS', 'DISTINCT', 'TOP', 'LIMIT',
            'INTO', 'VALUES', 'SET',
            'PRIMARY KEY', 'FOREIGN KEY', 'REFERENCES',
            'UNIQUE', 'CHECK', 'DEFAULT', 'IDENTITY',
            'NULL', 'NOT NULL',
            'INT', 'VARCHAR', 'NVARCHAR', 'DECIMAL', 'DATE', 'DATETIME', 'BIT',
            'COUNT', 'SUM', 'AVG', 'MIN', 'MAX',
            'EXEC', 'EXECUTE', 'PROCEDURE', 'FUNCTION', 'TRIGGER',
            'BEGIN', 'END', 'IF', 'ELSE', 'WHILE', 'RETURN',
            'TRY', 'CATCH', 'THROW', 'RAISERROR',
            'TRANSACTION', 'COMMIT', 'ROLLBACK',
            'GRANT', 'REVOKE', 'DENY',
            'USE', 'GO'
        ];
        
        let highlighted = sql;
        
        // Resaltar palabras clave
        keywords.forEach(keyword => {
            const regex = new RegExp('\\b' + keyword + '\\b', 'gi');
            highlighted = highlighted.replace(regex, `<span class="keyword">${keyword}</span>`);
        });
        
        // Resaltar strings
        highlighted = highlighted.replace(/'[^']*'/g, '<span class="string">$&</span>');
        
        // Resaltar números
        highlighted = highlighted.replace(/\b\d+\b/g, '<span class="number">$&</span>');
        
        // Resaltar comentarios
        highlighted = highlighted.replace(/--.*/g, '<span class="comment">$&</span>');
        
        // Resaltar funciones
        const functions = [
            'GETDATE', 'NEWID', 'ISNULL', 'NULLIF', 'COALESCE',
            'CONVERT', 'CAST', 'LEN', 'SUBSTRING', 'REPLACE',
            'UPPER', 'LOWER', 'LTRIM', 'RTRIM', 'CONCAT'
        ];
        
        functions.forEach(func => {
            const regex = new RegExp('\\b' + func + '\\b', 'gi');
            highlighted = highlighted.replace(regex, `<span class="function">${func}</span>`);
        });
        
        block.innerHTML = highlighted;
    });
    
    // Contador animado para estadísticas (si existen)
    const counters = document.querySelectorAll('[data-count]');
    
    const countObserver = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const target = parseInt(counter.getAttribute('data-count'));
                const duration = 2000;
                const step = target / (duration / 16);
                let current = 0;
                
                const updateCounter = function() {
                    current += step;
                    if (current < target) {
                        counter.textContent = Math.floor(current);
                        requestAnimationFrame(updateCounter);
                    } else {
                        counter.textContent = target;
                    }
                };
                
                updateCounter();
                countObserver.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });
    
    counters.forEach(counter => {
        countObserver.observe(counter);
    });
    
    // Búsqueda en la documentación (si existe la funcionalidad)
    const searchInput = document.getElementById('searchInput');
    
    if (searchInput) {
        searchInput.addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.topic-card');
            
            cards.forEach(card => {
                const title = card.querySelector('h3').textContent.toLowerCase();
                const description = card.querySelector('p').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || description.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    }
    
    // Tooltip para elementos de arquitectura
    const archLayers = document.querySelectorAll('.arch-layer');
    
    archLayers.forEach(layer => {
        layer.addEventListener('mouseenter', function() {
            this.style.cursor = 'pointer';
        });
    });
    
    // Console welcome message
    console.log('%c📊 SQL Server desde Cero', 'font-size: 20px; font-weight: bold; color: #0078d4;');
    console.log('%c¡Bienvenido al curso de SQL Server!', 'font-size: 14px; color: #666;');
    console.log('%cExplora la documentación y ejemplos para aprender.', 'font-size: 12px; color: #999;');
    
});

// Función para copiar código al portapapeles
function copyCode(button) {
    const codeBlock = button.parentElement.querySelector('code');
    const code = codeBlock.textContent;
    
    navigator.clipboard.writeText(code).then(() => {
        const originalText = button.textContent;
        button.textContent = '¡Copiado!';
        button.style.background = '#107c10';
        
        setTimeout(() => {
            button.textContent = originalText;
            button.style.background = '';
        }, 2000);
    }).catch(err => {
        console.error('Error al copiar:', err);
        button.textContent = 'Error';
    });
}

// Función para cambiar tema (claro/oscuro)
function toggleTheme() {
    const body = document.body;
    const themeToggle = document.getElementById('themeToggle');
    
    body.classList.toggle('dark-theme');
    
    if (body.classList.contains('dark-theme')) {
        themeToggle.textContent = '☀️';
        localStorage.setItem('theme', 'dark');
    } else {
        themeToggle.textContent = '🌙';
        localStorage.setItem('theme', 'light');
    }
}

// Cargar tema guardado
document.addEventListener('DOMContentLoaded', function() {
    const savedTheme = localStorage.getItem('theme');
    const themeToggle = document.getElementById('themeToggle');
    
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-theme');
        if (themeToggle) {
            themeToggle.textContent = '☀️';
        }
    }
});

// Exportar funciones para uso global
window.copyCode = copyCode;
window.toggleTheme = toggleTheme;
